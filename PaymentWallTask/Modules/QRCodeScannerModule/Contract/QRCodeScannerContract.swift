//
//  QRCodeScannerContract.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import Foundation
import RxSwift


//MARK: - Router
enum QRCodeScannerRoute {
}

protocol QRCodeScannerRouterProtocol: class {
    func go(to route:QRCodeScannerRoute)
}



//MARK: - Presenter
protocol QRCodeScannerPresenterProtocol: class {
    func attach()
    var viewModel: QRCodeScannerViewModel  { get }

}



//MARK: - Interactor
protocol QRCodeScannerInteractorProtocol: class {

    
}



//MARK: - View
protocol QRCodeScannerViewControllerProtocol: class {

    var presenter: QRCodeScannerPresenterProtocol?  { get set }
}
