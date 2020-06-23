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
            .compactMap { $0 }
            .bind(to: viewModel.transaction)
            .disposed(by: disposeBag)
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
