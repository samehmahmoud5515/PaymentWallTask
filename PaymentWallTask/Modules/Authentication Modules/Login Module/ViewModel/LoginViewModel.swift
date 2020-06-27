//
//  LoginViewModel.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/22/20.
//
//

import RxSwift

struct LoginViewModel {
    
    //localization
    let localization =  LoginLocalization()
    
    let emailText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    
    var entriesValidation = LoginEntriesValidation()
    
    //taps
    let loginDidTapped = PublishSubject<Void>()
    let signupDidTapped = PublishSubject<Void>()
    
}
