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
        let transaction = Transaction(JSONString: json)
        return transaction?.currency == nil ? nil : transaction
    }
    
    func buildDescripitonMessageFrom(transaction: Transaction) -> String {
        return "\(transaction.businessName) \(transaction.paymentAmount) \(transaction.currency?.rawValue ?? "")?"
    }
 
}
