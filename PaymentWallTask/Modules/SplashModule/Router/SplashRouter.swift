//
//  SplashRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/24/20.
//
//

import UIKit

class SplashRouter: SplashRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {

        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    //MARK: - Routing
    func go(to route:SplashRoute) {
        switch route {
        case .login:
            let loginVc = LoginRouter.assembleModule()
            viewController?.navigationController?.setViewControllers([loginVc], animated: false)
        case .home:
            let homeVc = HomeRouter.assembleModule()
            viewController?.navigationController?.setViewControllers([homeVc], animated: false)
        }
    }

}
