//
//  SignupRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/25/20.
//
//

import UIKit

class SignupRouter: SignupRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {

        let view = SignupViewController()
        let interactor = SignupInteractor()
        let router = SignupRouter()
        let presenter = SignupPresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    //MARK: - Routing
    func go(to route:SignupRoute) {
        switch route {
        case .login:
            viewController?.navigationController?.popViewController(animated: true)
        case .home:
            let homeVC = HomeRouter.assembleModule()
            viewController?.navigationController?.setViewControllers([homeVC], animated: false)
        }
    }

}
