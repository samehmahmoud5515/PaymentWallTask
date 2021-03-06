//
//  TransactionProtocol.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/25/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift

protocol TransactionProtocol {
    func fetchUserTransactions(with email: String) -> Observable<[Transaction]>
    func confirmTransactionForUser(email: String, transaction: Transaction) -> Observable<Void>
}

extension TransactionProtocol {
    
    func fetchUserTransactions(with email: String) -> Observable<[Transaction]> {
        let service = UserDatabaseService.shared
        return service.fetchUserTransactions(with: email)
            .flatMap { transacions -> Observable<[Transaction]> in
                let sortedTransactions = transacions.filter { $0.date != nil }
                    .sorted(by: { $0.date! > $1.date! }).prefix(10)
                
                return Observable.just(Array(sortedTransactions))
            }
    }
    
    func confirmTransactionForUser(email: String, transaction: Transaction) -> Observable<Void> {
        let service = UserDatabaseService.shared
        return service.fetchUserFromDBWith(email: email)
            .flatMap { user -> Observable<Void> in
                if user.currency != transaction.currency {
                    return Observable.error(TransactionProtocolError.differentCurrency)
                }
                if user.balance < transaction.paymentAmount {
                    return Observable.error(TransactionProtocolError.notEnoughBalance)
                }
                var updatedTransaction = transaction
                updatedTransaction.date = Date()
                var updatedUser = user
                updatedUser.balance -= transaction.paymentAmount
                updatedUser.transactions.append(updatedTransaction)
                return service.saveUser(user: updatedUser)
            }
    }
}

enum TransactionProtocolError: Error {
    case differentCurrency
    case notEnoughBalance
}
