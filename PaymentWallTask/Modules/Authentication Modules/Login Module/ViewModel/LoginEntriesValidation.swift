//
//  LoginEntriesValidation.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift

class LoginEntriesValidation {
    
    var email: LoginEntryState = .empty
    var password: LoginEntryState = .empty
    
    var isAllEntryValid: Observable<Bool> {
        let isvalid = email.isValid && password.isValid
        return Observable.just(isvalid)
    }
}
