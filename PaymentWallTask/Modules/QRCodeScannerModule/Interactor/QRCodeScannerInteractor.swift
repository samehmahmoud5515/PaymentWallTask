//
//  QRCodeScannerInteractor.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift


class QRCodeScannerInteractor: QRCodeScannerInteractorProtocol {
    
    func parseTransaction(from json: String) -> Transaction? {
        return Transaction(JSONString: json)
    }
    
    func buildDescripitonMessageFrom(transaction: Transaction) -> String {
        return "\(transaction.businessName) \(transaction.paymentAmount) \(transaction.currency?.rawValue ?? "")?"
    }
 
}


import ObjectMapper

struct Transaction: Mappable {
    
    var paymentAmount: Double = 0.0
    var businessName: String = ""
    var description: String = ""
    var currency: Currency?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        paymentAmount <- map["paymentAmount"]
        businessName <- map["businessName"]
        description <- map["description"]
        currency <- (map["currency"], EnumTransform<Currency>())
    }
    
}

enum Currency: String {
    case USD = "USD"
    case EUR = "EUR"
    case GBP = "GBP"
}
