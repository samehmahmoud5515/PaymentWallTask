//
//  UserInfoProtocol.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/24/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift

protocol UserInfoProtocol {
    func fetchAllUsers() -> Observable<[User]>
    func saveUser(user: User) -> Observable<Void>
    func fetchUserTransactions(with email: String) -> Observable<[Transaction]>
    func updateTransactionForUser(email: String, transaction: Transaction) -> Observable<Void>
}

extension UserInfoProtocol {
    
    func fetchAllUsers() -> Observable<[User]> {
        let service = UserDatabaseService.shared
        return service.fetchAllUsersFromDB()
    }
    
    func saveUser(user: User) -> Observable<Void> {
        let service = UserDatabaseService.shared
        return service.saveUser(user: user)
    }
    
    func fetchUserTransactions(with email: String) -> Observable<[Transaction]> {
        let service = UserDatabaseService.shared
        return service.fetchUserTransactions(with: email)
    }
    
    func updateTransactionForUser(email: String, transaction: Transaction) -> Observable<Void> {
        let service = UserDatabaseService.shared
        return service.fetchUserFromDBWith(email: email)
            .flatMap { user -> Observable<Void> in
                var updatedUser = user
                updatedUser.transactions.append(transaction)
                return service.saveUser(user: updatedUser)
            }
    }

}
