//
//  SignupEntryState.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

enum SignupEntryState {
    case valid
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
