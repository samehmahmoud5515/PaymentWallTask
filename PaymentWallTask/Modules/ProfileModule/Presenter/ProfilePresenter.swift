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
    

    func attach() {
        handleLogoutDidTapped()
        fetchCurrentUser()
    }
    
    private func handleLogoutDidTapped() {
        viewModel.logoutButtonDidTap.subscribe(onNext: { [weak self] _ in
            self?.interactor?.logout()
            self?.navigateLogin()
        }).disposed(by: disposeBag)
    }
    
    private func fetchCurrentUser() {
        interactor?.currentUser.subscribe(onNext: { [weak self] user in
            self?.viewModel.user.onNext(user)
        }).disposed(by: disposeBag)
    }
}

extension ProfilePresenter {
    private func navigateLogin() {
        router.go(to: .login)
    }
}
