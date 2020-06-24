//
//  LoginProtocol.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/24/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift

protocol LoginProtocol {
    func login(email: String, password: String) -> Observable<Bool>
}

extension LoginProtocol {
    
    func login(email: String, password: String) -> Observable<Bool> {
        
        let databaseService = UserDatabaseService.shared
        return databaseService.fetchUserFromDBWith(email: email)
            .catchError { error -> Observable<User> in
                return Observable.error(LoginProtocolError.wrongUserNameOrPassword)
            }
            .flatMap { user -> Observable<Bool> in
                if user.password == password {
                    let keyChainService = KeychainService()
                    keyChainService.storeLoggedInEmail(email: user.email)
                    return Observable.just(true)
                }
                return Observable.just(false)
            }
    }
}

enum LoginProtocolError: Error {
    case wrongUserNameOrPassword
}
