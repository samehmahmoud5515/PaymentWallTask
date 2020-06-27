//
//  SignupEntriesValidation.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift

class SignupEntriesValidation {
    
    var email: SignupEntryState = .empty
    var password: SignupEntryState = .empty
    var firstName: SignupEntryState = .empty
    var lastName: SignupEntryState = .empty
    var birthDate: SignupEntryState = .empty
    
    var isAllEntryValid: Observable<Bool> {
        let isvalid = email.isValid && password.isValid && firstName.isValid && lastName.isValid && birthDate.isValid
        return Observable.just(isvalid)
    }
}
