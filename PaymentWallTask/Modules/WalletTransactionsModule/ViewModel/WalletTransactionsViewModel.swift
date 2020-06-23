//
//  WalletTransactionsViewModel.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxDataSources
import RxSwift

struct WalletTransactionsViewModel {
    //tableView data sources
    let transactionsDatasource = BehaviorSubject<[CategorizedTransaction]>(value: [])
    
    let localization =  WalletTransactionsLocalization()
}

struct TransactionEntity {
    
}



struct CategorizedTransaction {
    var header: String
    var items: [TransactionEntity]
}

extension CategorizedTransaction: SectionModelType {
    
    init(original: CategorizedTransaction, items: [TransactionEntity]) {
        self = original
        self.items = items
    }
}
