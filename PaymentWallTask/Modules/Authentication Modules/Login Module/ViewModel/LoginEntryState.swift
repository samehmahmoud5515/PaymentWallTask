//
//  LoginEntryState.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

enum LoginEntryState {
    case empty
    case valid
}

extension LoginEntryState {
    
    var isValid: Bool {
        switch self {
        case .valid:
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
