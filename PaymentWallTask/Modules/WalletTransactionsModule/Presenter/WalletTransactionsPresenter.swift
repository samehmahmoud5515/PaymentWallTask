//
//  WalletTransactionsPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift

class WalletTransactionsPresenter: WalletTransactionsPresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: WalletTransactionsViewControllerProtocol?
    var interactor: WalletTransactionsInteractorProtocol?
    private let router: WalletTransactionsRouterProtocol
    private let disposeBag = DisposeBag()
    let viewModel = WalletTransactionsViewModel()

    
    
    //MARK:- init
    init(viewController: WalletTransactionsViewControllerProtocol, interactor: WalletTransactionsInteractorProtocol?, router: WalletTransactionsRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        fetchUserTransactions()
        bindUserBalanceObservable()
        handleEmptyTransaction()
    }
    
    private func fetchUserTransactions() {
        guard let email = interactor?.getUserEmail() else { return }
        interactor?.fetchUserTransactions(with: email)
            .subscribe(onNext: { [weak self] transactions in
                let categorizedTransaction = self?.interactor?.cateogrizeTransactionWithDate(transactions: transactions) ?? []
                self?.viewModel.transactionsDatasource.onNext(categorizedTransaction)
                self?.viewController?.removeEmptyTransactionsView()
        }).disposed(by: disposeBag)
    }
    
    private func bindUserBalanceObservable() {
        interactor?.currentUser
            .map { "\($0.balance) \($0.currency?.rawValue ?? "")" }
            .subscribe(onNext: { [weak self] balance in
                self?.viewModel.userBalance.onNext(balance)
            }).disposed(by: disposeBag)
    }
    
    private func handleReloadFetchingTransactions() {
        viewModel.reloadFetchingTransactions
            .flatMap { [weak self] _ -> Observable<[Transaction]> in
                guard let email = self?.interactor?.getUserEmail() else { return Observable.empty() }
                return self?.interactor?.fetchUserTransactions(with: email) ?? Observable.empty()
            }.subscribe(onNext: { [weak self] transactions in
                let categorizedTransaction = self?.interactor?.cateogrizeTransactionWithDate(transactions: transactions) ?? []
                self?.viewModel.transactionsDatasource.onNext(categorizedTransaction)
            }).disposed(by: disposeBag)
    }
    
    private func handleEmptyTransaction() {
        viewModel.transactionsDatasource
            .filter { $0.isEmpty }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.viewController?.displayEmptyTransactionsView()
            }).disposed(by: disposeBag)
    }

}
