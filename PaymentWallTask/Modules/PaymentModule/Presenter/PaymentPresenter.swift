//
//  PaymentPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift

class PaymentPresenter {

    
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
        bindUserBalanceObservable()
        handlePayButtonDidTapped()
        handleTransactionSuccessOkButtonTap()
        observeOnErrorDidHappendWhilePayment()
    }
    
    private func bindUserBalanceObservable() {
        interactor?.currentUser
            .map { "\($0.balance) \($0.currency?.rawValue ?? "")" }
            .subscribe(onNext: { [weak self] balance in
                self?.viewModel.userBalance.onNext(balance)
            })
            .disposed(by: disposeBag)
    }
    
    private func handlePayButtonDidTapped() {
        viewModel.payButtonTap
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let transaction = self?.viewModel.transaction,
                let email = self?.interactor?.getUserEmail()
                    else { return Observable.empty() }
                return self?.interactor?.confirmTransactionForUser(email: email, transaction: transaction)
                    .catchError { [weak self] error -> Observable<()> in
                        self?.viewModel.errorDidHappendWhilePayment.onNext(error)
                        return Observable.empty()
                    } ?? Observable.empty()
            }.subscribe(onNext: { [weak self] _ in
                self?.viewController?.displayPaymentSuccessedView()
            }).disposed(by: disposeBag)
    }
    
    private func handleTransactionSuccessOkButtonTap() {
        viewModel.transactionSuccessOkButtonTap
            .subscribe(onNext: { [weak self] _ in
                self?.viewController?.removePaymentSuccessedView()
                self?.router.go(to: .back)
            }).disposed(by: disposeBag)
    }
    
    private func observeOnErrorDidHappendWhilePayment() {
        viewModel.errorDidHappendWhilePayment
            .subscribe(onNext: { [weak self] error in
                self?.handlePaymentsError(error)
            }).disposed(by: disposeBag)
    }
    
    private func handlePaymentsError(_ error: Error) {
        let localization = viewModel.localization
        switch error {
        case TransactionProtocolError.differentCurrency:
            viewController?.displayAlertWith(title: localization.differentCurrencyTitle, message: "\(localization.differentCurrencyMessage)  \(viewModel.transaction.currency?.rawValue ?? "")")
        case TransactionProtocolError.notEnoughBalance:
            viewController?.displayAlertWith(title: localization.notEnoughBalanceTitle, message: "\(localization.notEnoughBalanceMessage)")
        default:
            break
        }
    }
    
    
}

extension PaymentPresenter: PaymentPresenterProtocol {
    func genrateRandomString(of size: Int) -> String? {
        return interactor?.genrateRandomString(of: size)
    }
}
