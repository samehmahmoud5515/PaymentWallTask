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
