//
//  HomePresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift

class HomePresenter: HomePresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: HomeViewControllerProtocol?
    var interactor: HomeInteractorProtocol?
    private let router: HomeRouterProtocol
    private let disposeBag = DisposeBag()
    var viewModel =  HomeViewModel ()  

    
    
    //MARK:- init
    init(viewController: HomeViewControllerProtocol, interactor: HomeInteractorProtocol?, router: HomeRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        
        
    }
    

}
