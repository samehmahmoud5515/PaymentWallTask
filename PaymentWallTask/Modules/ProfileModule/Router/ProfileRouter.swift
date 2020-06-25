//
//  ProfileRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {

        let view = ProfileViewController()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    //MARK: - Routing
    func go(to route: ProfileRoute) {
        switch route {
        case .login:
            let loginVc = LoginRouter.assembleModule()
            viewController?.navigationController?.navigationController?.setViewControllers([loginVc], animated: false)
        }
    }

}
