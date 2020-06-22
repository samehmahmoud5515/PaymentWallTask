//
//  LoginPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/22/20.
//
//

import RxSwift

class LoginPresenter: LoginPresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: LoginViewControllerProtocol?
    var interactor: LoginInteractorProtocol?
    private let router: LoginRouterProtocol
    private let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()

    
    
    //MARK:- init
    init(viewController: LoginViewControllerProtocol, interactor: LoginInteractorProtocol?, router: LoginRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        
        
    }
    
    //MARK:- Private functions

}
