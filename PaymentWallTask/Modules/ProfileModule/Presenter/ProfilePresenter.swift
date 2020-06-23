//
//  ProfilePresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift

class ProfilePresenter: ProfilePresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: ProfileViewControllerProtocol?
    var interactor: ProfileInteractorProtocol?
    private let router: ProfileRouterProtocol
    private let disposeBag = DisposeBag()
    var viewModel =  ProfileViewModel ()  

    
    
    //MARK:- init
    init(viewController: ProfileViewControllerProtocol, interactor: ProfileInteractorProtocol?, router: ProfileRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        
       
    }
    
    //MARK:- Private functions

}
