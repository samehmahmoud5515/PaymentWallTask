//
//  QRCodeScannerRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit

class QRCodeScannerRouter: QRCodeScannerRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = QRCodeScannerViewController()
        let interactor = QRCodeScannerInteractor()
        let router = QRCodeScannerRouter()
        let presenter = QRCodeScannerPresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    //MARK: - Routing
    func go(to route:QRCodeScannerRoute) {
        switch route {
        default: break
        }
    }

}
