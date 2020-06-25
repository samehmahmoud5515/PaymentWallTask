//
//  UserDatabaseService.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/22/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxRealm
import RealmSwift
import RxSwift

class UserDatabaseService {
    
    var realm: Realm!
    static let shared = UserDatabaseService()
    
    private init() {
        do {
            guard let defaultUrl = Realm.Configuration.defaultConfiguration.fileURL else { return }
            
            let config = Realm.Configuration (
                fileURL: defaultUrl.deletingLastPathComponent().appendingPathComponent("User.realm")
                , schemaVersion: 5
                , deleteRealmIfMigrationNeeded: true
                , objectTypes: [UserEntity.self, TransactionEntity.self]
            )
            
            realm = try Realm(configuration: config)

        } catch {
            print(error)
        }
    }
    
    func saveUser(user: User) -> Observable<Void> {
        do {
            try self.realm.safeWrite {
                self.realm.add(user.toUserEntity, update: .modified)
            }
        } catch {
            return Observable.error(error)
        }
        guard let entity = realm.objects(UserEntity.self)
            .first else { return Observable.error(StandardError.notSavedInDatabase) }
        return Observable.from(object: entity)
            .map { _ in () }
    }
    
    func fetchAllUsersFromDB() -> Observable<[User]> {
        let entities = realm.objects(UserEntity.self)
        return Observable.array(from: entities).map { $0.map { $0.toUser } }
    }
    
    func fetchUserFromDBWith(email: String) -> Observable<User> {
        let entities = realm.objects(UserEntity.self)
            .filter(NSPredicate(format: "email = %@", email))
        guard let entity = entities.first else {
            return Observable.error(StandardError.notFoundInDatabase)
        }
        return Observable.from(object: entity).map { $0.toUser }
    }
    
    func isEmailExist(email: String) -> Observable<Bool> {
        let entities = realm.objects(UserEntity.self)
            .filter(NSPredicate(format: "email = %@", email))
        guard (entities.first != nil) else {
            return Observable.just(false)
        }
        return Observable.just(true)
    }
    
    func fetchUserTransactions(with email: String) -> Observable<[Transaction]> {
        let entities = realm.objects(UserEntity.self)
            .filter(NSPredicate(format: "email = %@", email))
        guard let entity = entities.first else {
            return Observable.just([])
        }
        return Observable.from(object: entity)
            .map { $0.transactions }
            .map { $0.map { $0.toTransaction }}
    }
    
    func deleteAllCachedUsers() -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            do {
                try self.realm.safeWrite {
                    self.realm.deleteAll()
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                print(error)
            }
            return Disposables.create()
        }
    }
    
}
