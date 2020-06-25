//
//  UserEntity.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/22/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RealmSwift

class UserEntity: Object {
    
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var balance: Double = 0.0
    @objc dynamic var currency: String = ""
    var transactions = List<TransactionEntity>()
    
    override static func primaryKey() -> String? {
        return "email"
    }
}

// MARK: - Mapping
extension UserEntity {
    
    var toUser: User {
        var user = User()
        user.email = email
        user.password = password
        user.balance = balance
        user.currency = Currency(rawValue: currency)
        user.firstName = firstName
        user.lastName = lastName
        user.transactions = transactions.map { $0.toTransaction }
        return user
    }
}
