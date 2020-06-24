//
//  RootRouter.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/19/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import UIKit

class RootRouter {
        
    private var window: UIWindow!
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
        setupRootNavigationController()
    }
    
    private func setupRootNavigationController() {
        navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

extension RootRouter: RootRouterProtocol {
    
    func go(to route: RootRoute) {
        switch route {
        case .splash:
            let splashVC = SplashRouter.assembleModule()
            navigationController.setViewControllers([splashVC], animated: false)
        }
    }
    
}
