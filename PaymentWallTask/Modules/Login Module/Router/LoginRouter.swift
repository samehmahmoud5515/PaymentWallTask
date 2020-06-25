//
//  LoginRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/22/20.
//
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {
        
        let view = LoginViewController()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    //MARK: - Routing
    func go(to route:LoginRoute) {
        switch route {
        case .home:
            let homeViewController = HomeRouter.assembleModule()
            viewController?.navigationController?.setViewControllers([homeViewController], animated: false)
        case .signup:
            let signupVc = SignupRouter.assembleModule()
            viewController?.navigationController?.pushViewController(signupVc, animated: true)
        }
    }

}
