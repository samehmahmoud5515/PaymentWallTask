//
//  SignupProtocol.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/25/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift

protocol SignupProtocol {
    func signup(email: String, password: String, firstName: String, lastName: String, birthDate: String) -> Observable<Void>
    
}

extension SignupProtocol {
    
    func signup(email: String, password: String, firstName: String, lastName: String, birthDate: String) -> Observable<Void> {
        //choose random balance and currency
        let balance = Int.random(in: 0 ..< 10000)
        let currency = [Currency.USD, Currency.EUR, Currency.GBP].randomElement()
        let user = User(email: email, password: password, firstName: firstName, lastName: lastName, birthDate: birthDate.toDate(), balance: Double(balance), currency: currency, transactions: [])
        
        let service = UserDatabaseService.shared
        return service.isEmailExist(email: email)
            .flatMap { isExist -> Observable<Void> in
                if isExist {
                    return Observable.error(SignupProtocolError.emailExist)
                }
                let keyChainService = KeychainService()
                keyChainService.storeLoggedInEmail(email: email)
                return service.saveUser(user: user)
            }
    }
}

enum SignupProtocolError: Error {
    case emailExist
}
