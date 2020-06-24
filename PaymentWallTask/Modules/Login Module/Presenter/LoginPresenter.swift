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
        handleLoginDidTapped()
    }
    
    private func handleLoginDidTapped() {
        
        let emailPasswordObs = Observable.combineLatest(viewModel.emailText, viewModel.passwordText)
        
        viewModel.loginDidTapped
            .withLatestFrom(emailPasswordObs)
            .flatMap { [weak self] (email, password) -> Observable<Bool> in
                return self?.interactor?.login(email: email, password: password)
                    .catchError { error -> Observable<Bool> in
                        return Observable.just(false)
                    } ?? Observable.empty()
            }
            .subscribe(onNext: { [weak self] success in
                success ? self?.navigateToHome() : self?.displayLoginFailed()
            }).disposed(by: disposeBag)
    }
    
    private func displayLoginFailed() {
        let localization = viewModel.localization
        viewController?.displayAlertWith(title: localization.loginFailedTitle, message: localization.loginFailedMessage)
    }

}

//MARK: - Navigation
extension LoginPresenter {
    private func navigateToHome() {
        router.go(to: .home)
    }
}
