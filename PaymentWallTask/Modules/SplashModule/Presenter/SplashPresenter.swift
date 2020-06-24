//
//  SplashPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/24/20.
//
//

import RxSwift

class SplashPresenter: SplashPresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: SplashViewControllerProtocol?
    var interactor: SplashInteractorProtocol?
    private let router: SplashRouterProtocol
    private let disposeBag = DisposeBag()
    var viewModel =  SplashViewModel ()  

    
    
    //MARK:- init
    init(viewController: SplashViewControllerProtocol, interactor: SplashInteractorProtocol?, router: SplashRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.handleIsThereLoggedUser()
        }
    }
    
    private func handleIsThereLoggedUser() {
        if interactor?.isThereLoggedUser ?? false {
            navigateToHome()
        } else {
            navigateToLogin()
        }
    }

    //MARK: - Navigation
    private func navigateToHome() {
        router.go(to: .home)
    }
    
    private func navigateToLogin() {
        router.go(to: .login)
    }

}
