//
//  WalletTransactionModuleLayers.swift
//  PaymentWallTaskTests
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

@testable import PaymentWallTask

class WalletTransactionViewControllerMock: WalletTransactionsViewControllerProtocol {
    
    var isEmptyTransactionViewRemoved = false
    var isEmptyTransactionViewDisplayed = false
    var isAnimationStoped = false
    
    var presenter: WalletTransactionsPresenterProtocol?
    
    func removeEmptyTransactionsView() {
        isEmptyTransactionViewRemoved = true
    }
    
    func displayEmptyTransactionsView() {
        isEmptyTransactionViewDisplayed = true
    }
    
    func stopAnimatingRefreshControl() {
        isAnimationStoped = true
    }
}

class WalletTransactionsInteractorMock: WalletTransactionsInteractorProtocol {
    
    var shouldFail = false
    
    func cateogrizeTransactionWithDate(transactions: [Transaction]) -> [CategorizedTransaction] {
        return shouldFail ? [] : [CategorizedTransaction(header: "", items: [Transaction()])]
    }
    
}

// MARK: - MockPresenter
class WalletTransactionsPresneterMock: WalletTransactionsPresenterProtocol {
    weak private var viewController: WalletTransactionsViewControllerProtocol?
    private let router: WalletTransactionsRouterProtocol?
    var interactor: WalletTransactionsInteractorProtocol?
    var viewModel: WalletTransactionsViewModel

    init(viewController: WalletTransactionsViewControllerProtocol?,
         interactor: WalletTransactionsInteractorProtocol?,
         router: WalletTransactionsRouterProtocol?,
         viewModel: WalletTransactionsViewModel) {
        self.viewController = viewController
        self.interactor = interactor
        self.viewModel = viewModel
        self.router = router
    }
    
    func attach() {
    }
}

// MARK: - MockRouter
class WalletTransactionsRouterMock: WalletTransactionsRouterProtocol {
    func go(to route: WalletTransactionsRoute) {
        
    }
}
