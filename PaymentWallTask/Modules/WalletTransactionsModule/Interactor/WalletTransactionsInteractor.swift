//
//  WalletTransactionsInteractor.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift


class WalletTransactionsInteractor: WalletTransactionsInteractorProtocol {
    
    func cateogrizeTransactionWithDate(transactions: [Transaction]) -> [CategorizedTransaction] {
        var categorizedEpg: [CategorizedTransaction] = []
        let epgWithDates = transactions.filter {
            $0.date != nil
        }
        let dictionary = Dictionary(grouping: epgWithDates, by: { convertDateToString(date: $0.date!) })
        for item in dictionary {
            let valuesArraySorted = item.value.sorted(by: { $0.date! > $1.date! })
            categorizedEpg.append(CategorizedTransaction(header: item.key, items: valuesArraySorted))
        }
        return categorizedEpg.sorted { $0.header > $1.header }
    }
    
    private func convertDateToString(date: Date) -> String {
        return date.toForamt(format: Date.transactionDisplayFormat)
    }
    
}
