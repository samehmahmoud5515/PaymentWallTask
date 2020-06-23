//
//  AppDelegate.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/19/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootRouter: RootRouter?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureRootController()
        return true
    }


    
}

extension AppDelegate {
    private func configureRootController() {
        window = UIWindow()
        rootRouter = RootRouter(window: window!)
        rootRouter?.go(to: .splash)
    }
}
