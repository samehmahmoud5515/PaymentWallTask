//
//  PaymentRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit

class PaymentRouter: PaymentRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    
    //MARK:- Assemple
    static func assembleModule(transaction: Transaction) -> UIViewController {
        
        let view = PaymentViewController()
        let interactor = PaymentInteractor()
        let router = PaymentRouter()
        let presenter = PaymentPresenter(viewController: view, interactor: interactor, router: router)
        let viewModel = PaymentViewModel(transaction: transaction)
        
        presenter.viewModel = viewModel
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    //MARK: - Routing
    func go(to route:PaymentRoute) {
        
    }

}
