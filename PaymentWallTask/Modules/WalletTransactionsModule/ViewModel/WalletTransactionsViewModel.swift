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
    
    let reloadFetchingTransactions = PublishSubject<Void>()
    
    let userBalance = PublishSubject<String>()
    
    let localization =  WalletTransactionsLocalization()
}


struct CategorizedTransaction {
    var header: String
    var items: [Transaction]
}

extension CategorizedTransaction: SectionModelType {
    
    init(original: CategorizedTransaction, items: [Transaction]) {
        self = original
        self.items = items
    }
}
