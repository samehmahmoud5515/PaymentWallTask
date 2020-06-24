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
        viewModel.transactionsDatasource.onNext([
            CategorizedTransaction(header: "adas", items: [Transaction()]),
            CategorizedTransaction(header: "123", items: [Transaction(), Transaction()])
        ])
       
    }
    
    //MARK:- Private functions

}
