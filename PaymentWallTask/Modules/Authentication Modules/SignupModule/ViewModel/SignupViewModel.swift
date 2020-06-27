//
//  SignupViewModel.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/25/20.
//
//

import RxSwift
import RxCocoa

struct SignupViewModel {
    
    let email = PublishSubject<String>()
    let password = PublishSubject<String>()
    let firstName = PublishSubject<String>()
    let lastName = PublishSubject<String>()
    let birthDate = PublishSubject<String>()
    let agrementAgreeSwitch = BehaviorSubject<Bool>(value: true)
    var entriesValidation = SignupEntriesValidation()
    
    //taps
    let loginDidTapped = PublishSubject<Void>()
    let signupDidTapped = PublishSubject<Void>()
    
    let localization =  SignupLocalization()
}
