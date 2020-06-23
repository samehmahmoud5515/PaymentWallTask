//
//  QRCodeScannerPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit
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
        
    }
    
    //MARK:- Private functions

}
