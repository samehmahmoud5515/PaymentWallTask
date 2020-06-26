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

struct SignupEntriesValidation {
    
    var email: SignupEntryState = .empty
    var password: SignupEntryState = .empty
    var firstName: SignupEntryState = .empty
    var lastName: SignupEntryState = .empty
   // var isBirthDateValid: SignupEntryState = .empty
    
    var isAllEntryValid: Observable<Bool> {
        let isvalid = email.isValid && password.isValid && firstName.isValid && lastName.isValid
            //&& isBirthDateValid.isValid
        return Observable.just(isvalid)
    }
}

enum SignupEntryState {
    case valid(entry: String)
    case notValid
    case empty
}

extension SignupEntryState {
    var isValid: Bool {
        switch self {
        case .valid:
            return true
        default:
            return false
        }
    }
    
    var isNotValid: Bool {
        switch self {
        case .notValid:
            return true
        default:
            return false
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .empty:
            return true
        default:
            return false
        }
    }
}

extension String {
    func validateWith(pattern: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return validateWith(pattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
    }

    var isEmail: Bool {
        return validateWith(pattern:"^(.+)@(.+)$")
    }

    var isValidName: Bool {
        return validateWith(pattern: "^.{1,20}$")
    }
}
