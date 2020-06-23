//
//  WalletTransactionsRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit

class WalletTransactionsRouter: WalletTransactionsRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {
        
        let view = WalletTransactionsViewController()
        let interactor = WalletTransactionsInteractor()
        let router = WalletTransactionsRouter()
        let presenter = WalletTransactionsPresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    //MARK: - Routing
    func go(to route:WalletTransactionsRoute) {
        switch route {
        default: break
        }
    }

}
