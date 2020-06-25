//
//  SignupPresenter.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/25/20.
//
//

import RxSwift

class SignupPresenter: SignupPresenterProtocol {

    
    //MARK: - Attributes
    weak private var viewController: SignupViewControllerProtocol?
    var interactor: SignupInteractorProtocol?
    private let router: SignupRouterProtocol
    private let disposeBag = DisposeBag()
    let viewModel =  SignupViewModel()

    
    
    //MARK:- init
    init(viewController: SignupViewControllerProtocol, interactor: SignupInteractorProtocol?, router: SignupRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    
    
    //MARK:- Functions
    func attach() {
        handleLoginDidTapped()
        handleSignUpDidTappedInCaseAgrementSwitchIsOff()
        handleSignUpDidTappedInCaseAgrementSwitchIsOn()
    }
    
    private func handleLoginDidTapped() {
        viewModel.loginDidTapped
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToLogin()
            }).disposed(by: disposeBag)
    }
    
    private func handleSignUpDidTappedInCaseAgrementSwitchIsOff() {
        viewModel.signupDidTapped
            .withLatestFrom(viewModel.agrementAgreeSwitch)
            .filter { !$0 }
            .subscribe(onNext: { [weak self] _ in
                let localization = self?.viewModel.localization
                self?.viewController?.displayAlertWith(title: localization?.signupErrorTitle, message: localization?.aggrementErrorTitle)
            }).disposed(by: disposeBag)
    }
    
    private func handleSignUpDidTappedInCaseAgrementSwitchIsOn() {
        let textsObs = Observable.combineLatest(viewModel.email, viewModel.password, viewModel.firstName, viewModel.lastName)
        viewModel.signupDidTapped
            .withLatestFrom(viewModel.agrementAgreeSwitch)
            .filter { $0 }
            .withLatestFrom(textsObs)
            .subscribe(onNext: { [weak self] email, password, fName, lName in
                self?.signup(email: email, password: password, fName: fName, lName: lName)
            }).disposed(by: disposeBag)
    }
    
    private func signup(email: String, password: String, fName: String, lName: String) {
        interactor?.signup(email: email, password: password, firstName: fName, lastName: lName)
            .subscribe(onNext: { [weak self] () in
                self?.navigateToHome()
            }, onError: { [weak self] error in
                self?.handleSignupError(error)
            }).disposed(by: disposeBag)
    }
    
    private func handleSignupError(_ error: Error) {
        switch error {
        case SignupProtocolError.emailExist:
            let localiztion = viewModel.localization
            viewController?.displayAlertWith(title: localiztion.signupErrorTitle, message: localiztion.emailAlreadyExist)
        default:
            break
        }
    }

}

//MARK: - Navigation
extension SignupPresenter {
    
    private func navigateToLogin() {
        router.go(to: .login)
    }
    
    private func navigateToHome() {
        router.go(to: .home)
    }
}
