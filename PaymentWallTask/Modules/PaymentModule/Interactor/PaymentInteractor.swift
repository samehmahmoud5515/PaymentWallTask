//
//  PaymentInteractor.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift


class PaymentInteractor: PaymentInteractorProtocol {
    
    func genrateRandomString(of size: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomChars = (0..<size).map { _ in letters.randomElement() }.compactMap { $0 }
        return String(randomChars)
    }
 
}
