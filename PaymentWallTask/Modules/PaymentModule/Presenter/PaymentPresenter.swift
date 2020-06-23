//
//  PaymentPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift

class PaymentPresenter: PaymentPresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: PaymentViewControllerProtocol?
    var interactor: PaymentInteractorProtocol?
    private let router: PaymentRouterProtocol
    private let disposeBag = DisposeBag()
    var viewModel: PaymentViewModel!

    
    
    //MARK:- init
    init(viewController: PaymentViewControllerProtocol, interactor: PaymentInteractorProtocol?, router: PaymentRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        handlePayButtonDidTapped()
        handleTransactionSuccessOkButtonTap()
    }
    
    private func handlePayButtonDidTapped() {
        viewModel.payButtonTap.subscribe(onNext: { [weak self] _ in
            self?.viewController?.displayPaymentSuccessedView()
        }).disposed(by: disposeBag)
    }
    
    private func handleTransactionSuccessOkButtonTap() {
        viewModel.transactionSuccessOkButtonTap
            .subscribe(onNext: { [weak self] _ in
                self?.viewController?.removePaymentSuccessedView()
            }).disposed(by: disposeBag)
    }
    
    func genrateRandomString(of size: Int) -> String? {
        return interactor?.genrateRandomString(of: size)
    }
}
