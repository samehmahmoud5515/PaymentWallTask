//
//  SignupViewModel.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/25/20.
//
//

import RxSwift

struct SignupViewModel {
    
    let email = PublishSubject<String>()
    let password = PublishSubject<String>()
    let firstName = PublishSubject<String>()
    let lastName = PublishSubject<String>()
    let agrementAgreeSwitch = PublishSubject<Bool>()
    
    //taps
    let loginDidTapped = PublishSubject<Void>()
    let signupDidTapped = PublishSubject<Void>()
    
    let localization =  SignupLocalization()
}
