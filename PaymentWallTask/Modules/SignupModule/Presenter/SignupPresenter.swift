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
    var viewModel =  SignupViewModel()

    
    
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
        bindEntriesWithValidation()
        observeOnWrongEntries()
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
        let textsObs = Observable.combineLatest(viewModel.email, viewModel.password, viewModel.firstName, viewModel.lastName, viewModel.birthDate)
        viewModel.signupDidTapped
            .withLatestFrom(viewModel.agrementAgreeSwitch)
            .filter { $0 }
            .flatMap { [weak self] _ -> Observable<Bool> in
                return self?.viewModel.entriesValidation.isAllEntryValid ?? Observable.empty()
            }
            .filter { $0 }
            .withLatestFrom(textsObs)
            .subscribe(onNext: { [weak self] email, password, fName, lName, bdate in
                self?.signup(email: email, password: password, fName: fName, lName: lName, birthDate: bdate)
            }).disposed(by: disposeBag)
    }
    
    private func signup(email: String, password: String, fName: String, lName: String, birthDate: String) {
        interactor?.signup(email: email, password: password, firstName: fName, lastName: lName, birthDate: birthDate)
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

extension SignupPresenter {
    
    private func bindEntriesWithValidation() {
        bindEmailWithValidation()
        bindPasswordWithValidation()
        bindFirstNameWithValidation()
        bindLastNameWithValidation()
    }
    
    private func bindEmailWithValidation() {
        viewModel.email.subscribe(onNext: { [weak self] email in
            var entry: SignupEntryState = .empty
            if email.isEmail {
                entry = .valid(entry: email)
            } else {
                entry = email.isEmpty ? .empty : .notValid
            }
            self?.viewModel.entriesValidation.email = entry
        }).disposed(by: disposeBag)
    }
    
    private func bindPasswordWithValidation() {
        viewModel.password.subscribe(onNext: { [weak self] password in
            var entry: SignupEntryState = .empty
            if password.isValidPassword {
                entry = .valid(entry: password)
            } else {
                entry = password.isEmpty ? .empty : .notValid
            }
            self?.viewModel.entriesValidation.password = entry
        }).disposed(by: disposeBag)
    }
    
    private func bindFirstNameWithValidation() {
        viewModel.firstName.subscribe(onNext: { [weak self] fName in
            var entry: SignupEntryState = .empty
            if fName.isValidName {
                entry = .valid(entry: fName)
            } else {
                entry = fName.isEmpty ? .empty : .notValid
            }
            self?.viewModel.entriesValidation.firstName = entry
        }).disposed(by: disposeBag)
    }
    
    private func bindLastNameWithValidation() {
        viewModel.firstName.subscribe(onNext: { [weak self] lName in
            var entry: SignupEntryState = .empty
            if lName.isValidName {
                entry = .valid(entry: lName)
            } else {
                entry = lName.isEmpty ? .empty : .notValid
            }
            self?.viewModel.entriesValidation.lastName = entry
        }).disposed(by: disposeBag)
    }
}

extension SignupPresenter {
    private func observeOnWrongEntries() {
        viewModel.signupDidTapped
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
        if entries.email.isEmpty {
            viewController?.displayAlertWith(title: "empty email", message: "empty email")
            return
        } else if entries.email.isNotValid {
            viewController?.displayAlertWith(title: "wrong email", message: "wrong email")
            return
        }
        
        if entries.password.isEmpty {
            viewController?.displayAlertWith(title: "empty password", message: "empty password")
            return
        } else if entries.password.isNotValid {
            viewController?.displayAlertWith(title: "wrong password", message: "wrong password")
            return
        }
        
        if entries.firstName.isEmpty {
            viewController?.displayAlertWith(title: "empty firstName", message: "empty firstName")
            return
        } else if entries.firstName.isNotValid {
             viewController?.displayAlertWith(title: "wrong firstName", message: "wrong firstName")
            return
        }
        
        if entries.lastName.isEmpty {
            viewController?.displayAlertWith(title: "empty lastName", message: "empty lastName")
            return
        } else if entries.lastName.isNotValid {
            viewController?.displayAlertWith(title: "wrong lastName", message: "wrong lastName")
            return
        }
    }
}
