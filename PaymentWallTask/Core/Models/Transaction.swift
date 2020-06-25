//
//  Transaction.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/24/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import ObjectMapper

struct Transaction: Mappable {
    
    var paymentAmount: Double = 0.0
    var businessName: String = ""
    var currency: Currency?
    var date: Date?
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        paymentAmount <- map["paymentAmount"]
        businessName <- map["businessName"]
        currency <- (map["currency"], EnumTransform<Currency>())
    }
    
}

// MARK: - Mapping
extension Transaction {
    var toTransactionEntity: TransactionEntity {
        let transaction = TransactionEntity()
        transaction.businessName = businessName
        transaction.currency = currency?.rawValue ?? ""
        transaction.paymentAmount = paymentAmount
        transaction.date = date
        return transaction
    }
}
