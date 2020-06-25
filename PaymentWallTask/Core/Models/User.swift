//
//  User.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/24/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

struct User {
    var email: String = ""
    var password: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var balance: Double = 0.0
    var currency: Currency?
    var transactions: [Transaction] = []
}

// MARK: - Mapping
extension User {
    var toUserEntity: UserEntity {
        let user = UserEntity()
        user.email = email
        user.password = password
        user.firstName = firstName
        user.lastName = lastName
        user.balance = balance
        user.currency = currency?.rawValue ?? ""
        user.transactions.append(objectsIn: transactions.map { $0.toTransactionEntity })
        return user
    }
}
