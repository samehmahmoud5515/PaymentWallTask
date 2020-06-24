//
//  SplashInteractor.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/24/20.
//
//

import RxSwift


class SplashInteractor: SplashInteractorProtocol {
    
    var isThereLoggedUser: Bool {
        let keyChainService = KeychainService()
        return keyChainService.loggedInEmail != nil
    }
 
}
