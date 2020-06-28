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
        handleSignupDidTapped()
        bindEntriesWithValidation()
        observeOnWrongEntries()
    }
    
    private func handleLoginDidTapped() {
        
        let emailPasswordObs = Observable.combineLatest(viewModel.emailText, viewModel.passwordText)
        
        viewModel.loginDidTapped
            .flatMap { [weak self] _ -> Observable<Bool> in
                return self?.viewModel.entriesValidation.isAllEntryValid ?? Observable.empty()
            }
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
    
    private func handleSignupDidTapped() {
        viewModel.signupDidTapped
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToSignup()
            }).disposed(by: disposeBag)
    }

}

//MARK: - Navigation
extension LoginPresenter {
    private func navigateToHome() {
        router.go(to: .home)
    }
    
    private func navigateToSignup() {
        router.go(to: .signup)
    }
}

//MARK:- Validation
extension LoginPresenter {
    
    private func bindEntriesWithValidation() {
        bindEmailWithValidation()
        bindPasswordWithValidation()
    }
    
    private func bindEmailWithValidation() {
        viewModel.emailText.subscribe(onNext: { [weak self] email in
            let entry: LoginEntryState = email.isEmpty ? .empty : .valid
            self?.viewModel.entriesValidation.email = entry
        }).disposed(by: disposeBag)
    }
    
    private func bindPasswordWithValidation() {
        viewModel.passwordText.subscribe(onNext: { [weak self] password in
            let entry: LoginEntryState = password.isEmpty ? .empty : .valid
            self?.viewModel.entriesValidation.password = entry
        }).disposed(by: disposeBag)
    }
}

//MARK: - Handle Not valid entries
extension LoginPresenter {
    private func observeOnWrongEntries() {
        viewModel.loginDidTapped
            .flatMap { [weak self] _ -> Observable<Bool> in
                return self?.viewModel.entriesValidation.isAllEntryValid ?? Observable.empty()
            }
            .filter { !$0 }
            .subscribe(onNext: { [weak self] _ in
                self?.handleWrongEntries()
            }).disposed(by: disposeBag)
    }
    
    private func handleWrongEntries() {
        let entries = viewModel.entriesValidation
        if !entries.email.isValid {
            handleWrongEmail()
            return
        }
        
        if !entries.password.isValid {
            handleWrongPassword()
            return
        }
    }
    
    private func handleWrongEmail() {
        let localization = viewModel.localization
        if viewModel.entriesValidation.email.isEmpty {
            viewController?.displayAlertWith(title: localization.emptyEmail, message: nil)
        }
    }
    
    private func handleWrongPassword() {
        let localization = viewModel.localization
        if viewModel.entriesValidation.password.isEmpty {
            viewController?.displayAlertWith(title: localization.emptyPassword, message: nil)
        }
    }
}
