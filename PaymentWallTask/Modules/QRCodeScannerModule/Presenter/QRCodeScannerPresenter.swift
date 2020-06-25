//
//  QRCodeScannerPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift

class QRCodeScannerPresenter: QRCodeScannerPresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: QRCodeScannerViewControllerProtocol?
    var interactor: QRCodeScannerInteractorProtocol?
    private let router: QRCodeScannerRouterProtocol
    private let disposeBag = DisposeBag()
    var viewModel =  QRCodeScannerViewModel ()  

    
    
    //MARK:- init
    init(viewController: QRCodeScannerViewControllerProtocol, interactor: QRCodeScannerInteractorProtocol?, router: QRCodeScannerRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        bindTransactionRelayWithDidCaptureString()
        handleTransactionDidCaptured()
    }
    
    private func bindTransactionRelayWithDidCaptureString() {
        // map capture string form camera to Transaction Object
        viewModel.didCaptureString
            .map { [weak self] in return self?.interactor?.parseTransaction(from: $0)}
            .subscribe(onNext: { [weak self] transaction in
                if let transaction = transaction {
                    self?.viewModel.transaction.accept(transaction)
                } else {
                    self?.handleParsingError()
                }
            }).disposed(by: disposeBag)
    }
    
    private func handleParsingError() {
        let localization = viewModel.localization
        viewController?.displayDefaultAlert(title: localization.parsingError, message: localization.wrongFormattedQRCode, okTitle: localization.ok, actionBlock: { [weak self] in
            self?.viewController?.startCaptureRunning()
        })
    }
    
    private func handleTransactionDidCaptured() {
        viewModel.transaction.subscribe(onNext: { [weak self] transaction in
            self?.navigateToPayment(with: transaction)
        }).disposed(by: disposeBag)
    }
    

}

//MARK: - Navigation
extension QRCodeScannerPresenter {
    
    private func navigateToPayment(with transcation: Transaction) {
        router.go(to: .payment(transcation))
    }
}
