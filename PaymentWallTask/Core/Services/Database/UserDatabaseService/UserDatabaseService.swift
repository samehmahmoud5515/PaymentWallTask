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
            
            let config = Realm.Configuration(
                fileURL: defaultUrl.deletingLastPathComponent().appendingPathComponent("User.realm")
                , schemaVersion: 0
                , deleteRealmIfMigrationNeeded: true
                , objectTypes: [UserEntity.self]
            )
            
            realm = try Realm(configuration: config)
            try self.realm.safeWrite {
                self.realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    func saveUser(user: UserEntity) -> Observable<Void> {
        do {
            try self.realm.safeWrite {
                self.realm.add(user, update: .modified)
            }
        } catch {
            return Observable.error(error)
        }
        guard let entity = realm.objects(UserEntity.self)
            .first else { return Observable.empty() }
        return Observable.from(object: entity)
            .map { _ in () }
    }
    
    func fetchAllUsersFromDB() -> Observable<[UserEntity]> {
        let entities = realm.objects(UserEntity.self)
        return Observable.array(from: entities)
    }
    
    func isUserExistedInDB() -> Observable<Bool> {
        let entity = realm.objects(UserEntity.self)
        return Observable.collection(from: entity)
            .map { !$0.isEmpty }
            .share()
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
