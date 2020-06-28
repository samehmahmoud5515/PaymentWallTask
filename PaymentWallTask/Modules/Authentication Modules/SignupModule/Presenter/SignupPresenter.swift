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
    let viewModel = SignupViewModel()

    
    
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
        bindBirthDateWithValidation()
    }
    
    private func bindEmailWithValidation() {
        viewModel.email.subscribe(onNext: { [weak self] email in
            var entry: SignupEntryState = .empty
            if email.isEmail {
                entry = .valid
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
                entry = .valid
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
                entry = .valid
            } else {
                entry = fName.isEmpty ? .empty : .notValid
            }
            self?.viewModel.entriesValidation.firstName = entry
        }).disposed(by: disposeBag)
    }
    
    private func bindLastNameWithValidation() {
        viewModel.lastName.subscribe(onNext: { [weak self] lName in
            var entry: SignupEntryState = .empty
            if lName.isValidName {
                entry = .valid
            } else {
                entry = lName.isEmpty ? .empty : .notValid
            }
            self?.viewModel.entriesValidation.lastName = entry
        }).disposed(by: disposeBag)
    }
    
    private func bindBirthDateWithValidation() {
        viewModel.birthDate.subscribe(onNext: { [weak self] bDate in
            var entry: SignupEntryState = .empty
            if bDate.toDate() != nil {
                entry = .valid
            } else {
                entry = bDate.isEmpty ? .empty : .notValid
            }
            self?.viewModel.entriesValidation.birthDate = entry
        }).disposed(by: disposeBag)
    }
}

//MARK: - Handle Not valid entries
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
        if !entries.email.isValid {
            handleWrongEmail()
            return
        }
        
        if !entries.password.isValid {
            handleWrongPassword()
            return
        }
        
        if !entries.firstName.isValid {
            handleWrongFirstName()
            return
        }
        
        if !entries.lastName.isValid {
            handleWrongLastName()
            return
        }
        
        if !entries.birthDate.isValid {
            handleWrongBirthDate()
        }
    
    }
    
    private func handleWrongEmail() {
        let localization = viewModel.localization
        if viewModel.entriesValidation.email.isEmpty {
            viewController?.displayAlertWith(title: localization.emptyEmail, message: nil)
        } else if viewModel.entriesValidation.email.isNotValid {
            viewController?.displayAlertWith(title: localization.wrongEmailTitle, message: localization.wrongEmailMessage)
        }
    }
    
    private func handleWrongPassword() {
        let localization = viewModel.localization
        if viewModel.entriesValidation.password.isEmpty {
            viewController?.displayAlertWith(title: localization.emptyPassword, message: nil)
        } else if viewModel.entriesValidation.password.isNotValid {
            viewController?.displayAlertWith(title: localization.wrongPasswordTitle, message: localization.wrongPasswordMessage)
        }
    }
    
    private func handleWrongFirstName() {
        let localization = viewModel.localization
        if viewModel.entriesValidation.firstName.isEmpty {
            viewController?.displayAlertWith(title: localization.emptyFirstName, message: nil)
        } else if viewModel.entriesValidation.firstName.isNotValid {
            viewController?.displayAlertWith(title: localization.wrongFirstNameTitle, message: localization.wrongFirstNameMessage)
        }
    }
    
    private func handleWrongLastName() {
        let localization = viewModel.localization
        if viewModel.entriesValidation.lastName.isEmpty {
            viewController?.displayAlertWith(title: localization.emptyLastName, message: nil)
        } else if viewModel.entriesValidation.lastName.isNotValid {
            viewController?.displayAlertWith(title: localization.wrongLastNameTitle, message: localization.wrongLastNameMessage)
        }
    }
    
    private func handleWrongBirthDate() {
        let localization = viewModel.localization
        if viewModel.entriesValidation.birthDate.isEmpty {
            viewController?.displayAlertWith(title: localization.emptyBirthDate, message: nil)
        } else if viewModel.entriesValidation.birthDate.isNotValid {
            viewController?.displayAlertWith(title: localization.wrongBirthDateTitle, message: localization.wrongBirthDateMessage)
        }
    }
}
