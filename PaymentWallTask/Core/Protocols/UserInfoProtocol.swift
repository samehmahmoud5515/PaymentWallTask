//
//  UserInfoProtocol.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/24/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift


protocol UserInfoProtocol {
    func getUserEmail() -> String?
    func saveUser(user: User) -> Observable<Void>
    var currentUser: Observable<User> { get }
}

extension UserInfoProtocol {
    
    func getUserEmail() -> String? {
        let keyChainService = KeychainService()
        return keyChainService.loggedInEmail
    }
    
    func saveUser(user: User) -> Observable<Void> {
        let service = UserDatabaseService.shared
        return service.saveUser(user: user)
    }
    
    var currentUser: Observable<User> {
        guard let email = getUserEmail() else { return Observable.error(StandardError.notFoundInDatabase) }
        let service = UserDatabaseService.shared
        return service.fetchUserFromDBWith(email: email)
    }

}

