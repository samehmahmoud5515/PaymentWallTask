//
//  TransactionEntity.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/24/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RealmSwift

class TransactionEntity: Object {
    @objc dynamic var paymentAmount: Double = 0.0
    @objc dynamic var businessName: String = ""
    @objc dynamic var currency: String = ""
    @objc dynamic var date: Date?
}

// MARK: - Mapping
extension TransactionEntity {
    var toTransaction: Transaction {
        var transaction = Transaction()
        transaction.businessName = businessName
        transaction.currency = Currency(rawValue: currency)
        transaction.paymentAmount = paymentAmount
        transaction.date = date
        return transaction
    }
}
