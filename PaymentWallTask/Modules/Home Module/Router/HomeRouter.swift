//
//  HomeRouter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit

class HomeRouter: HomeRouterProtocol {
    
    
    //MARK: - Attributes
    weak var viewController: UIViewController?
    
    
    //MARK:- Assemple
    static func assembleModule() -> UIViewController {
        
        let view = createHomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    private static func createHomeViewController() -> HomeViewController {
        
        let walletViewController = createWalletTransactionController()
        let scannerViewController = createQRScanerController()
        let profileDViewController = createProfileController()
        
        let tabBarController = HomeViewController()
        
        tabBarController.viewControllers = [walletViewController,
                                            scannerViewController,
                                            profileDViewController,
                                            ]
        return tabBarController
    }
    
    private static func createWalletTransactionController() -> UINavigationController {
        let images = HomeImages()
        let title = HomeLocalization().wallet
        let walletController = WalletTransactionsRouter.assembleModule()
        let walletNavigation = UINavigationController(rootViewController: walletController)
        walletNavigation.setNavigationBarHidden(true, animated: false)
        walletController.tabBarItem = UITabBarItem(title: title,
                                                   image: UIImage(named: images.walletUnselectedImg),
                                                   selectedImage: UIImage(named: images.walletSelectedImg))
        walletController.tabBarItem.accessibilityIdentifier = "wallet_tab_id"
        return walletNavigation
    }
    
    private static func createQRScanerController() -> UINavigationController {
        let images = HomeImages()
        let title = HomeLocalization().scanner
        let scannerController = QRCodeScannerRouter.assembleModule()
        let scannerNavigation = UINavigationController(rootViewController: scannerController)
        scannerNavigation.navigationBar.tintColor = .white
        scannerNavigation.setNavigationBarHidden(true, animated: false)
        scannerController.tabBarItem = UITabBarItem(title: title,
                                                    image: UIImage(named: images.scannerUnselectedImg),
                                                    selectedImage: UIImage(named: images.scannerSelectedImg))
        return scannerNavigation
    }
    
    private static func createProfileController() -> UINavigationController {
        let images = HomeImages()
        let title = HomeLocalization().profile
        let profilerController = ProfileRouter.assembleModule()
        let profileNavigation = UINavigationController(rootViewController: profilerController)
        profileNavigation.setNavigationBarHidden(true, animated: false)
        profilerController.tabBarItem = UITabBarItem(title: title,
                                                     image: UIImage(named: images.profileUnselctedImg),
                                                     selectedImage: UIImage(named: images.profileSelectedImg))
        return profileNavigation
    }
    
    
    //MARK: - Routing
    func go(to route:HomeRoute) {
        
    }

}

