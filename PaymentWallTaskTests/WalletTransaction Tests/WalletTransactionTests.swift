//
//  WalletTransactionTests.swift
//  PaymentWallTaskTests
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift
import XCTest
@testable import PaymentWallTask

class WalletTransactionTests: XCTestCase {
    
    var viewModel: WalletTransactionsViewModel!
    var presenter: WalletTransactionsPresenter!
    var router: WalletTransactionsRouterProtocol!
    var view: WalletTransactionViewControllerMock!
    var interactor: WalletTransactionsInteractorMock!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        viewModel = WalletTransactionsViewModel()
        view = WalletTransactionViewControllerMock()
        router = WalletTransactionsRouterMock()
        interactor = WalletTransactionsInteractorMock()
        presenter = WalletTransactionsPresenter(viewController: view, interactor: interactor, router: router)
        presenter.attach()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        presenter = nil
        router = nil
        view = nil
        interactor = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testDisplayingIsEmptyTransactionViewInCaseEmptyTransaction() throws {
        interactor.shouldFail = true
        let val = interactor.cateogrizeTransactionWithDate(transactions: [])
        presenter?.viewModel.transactionsDatasource.onNext(val)
        
        XCTAssertTrue(view.isEmptyTransactionViewDisplayed)
    }
    
    func testGetUserEmail() throws {
        // In case user is Logged In
        XCTAssertNotNil(interactor.getUserEmail())
    }
    
    func testFetchTransactions() throws {
        // In case user is Logged In and there are transactions
        let email = interactor.getUserEmail()
        interactor.fetchUserTransactions(with: email ?? "").subscribe(onNext: { [weak self] transaction in
            self?.view.removeEmptyTransactionsView()
            self?.view.stopAnimatingRefreshControl()
        }).disposed(by: disposeBag)
        XCTAssertTrue(view.isEmptyTransactionViewRemoved)
    }
    
    func testStopAnimatingInCaseTransactions() throws {
        interactor.shouldFail = false
        let val = interactor.cateogrizeTransactionWithDate(transactions: [])
        presenter?.viewModel.transactionsDatasource.onNext(val)
        viewModel.reloadFetchingTransactions.onNext(())
        XCTAssertTrue(view.isAnimationStoped)
    }

    

}
