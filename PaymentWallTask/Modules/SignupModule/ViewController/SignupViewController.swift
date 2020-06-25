//
//  SignupViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/25/20.
//
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class SignupViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameNameTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var agrementAgreeSwitch: UISwitch!
    
    //MARK: - Attributes
	var presenter: SignupPresenterProtocol?
    let disposeBag = DisposeBag()
    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configuireUIBinding()
        handleTextFieldsDidEndEditing()
        presenter?.attach()
    }
    
}

//MARK: - Setup UI
extension SignupViewController {
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
        setupBirthDateTextFieldDelegate()
    }
    
    private func setupBirthDateTextFieldDelegate() {
        birthDateTextField.delegate = self
    }
}

//MARK: - UI Binding
extension SignupViewController {
    
    private func configuireUIBinding() {
        bindScrollViewContentOffSetWithKeybaordVisiable()
        bindbindScrollViewContentOffSetWithKeybaordHidden()
        bindLoginDidTappedWithLoginButtonTap()
        bindSignupDidTappedWithSignupButtonTap()
        bindEmailTextSubjectWithEmailTextField()
        bindPasswordTextSubjectWithEmailTextField()
        bindFirstNameTextSubjectWithEmailTextField()
        bindLastNameTextSubjectWithEmailTextField()
        bindBirthDateTextSubjectWithBirthdataTextField()
        bindAgrementAgreeSwitchSubjectWithAgrementAgreeSwitch()
    }
    
    private func bindScrollViewContentOffSetWithKeybaordVisiable() {
        RxKeyboard.instance.willShowVisibleHeight
            .drive(onNext: { [scrollView] keyboardVisibleHeight in
                scrollView?.contentOffset.y += keyboardVisibleHeight / 2
                scrollView?.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
    }
    
    private func bindbindScrollViewContentOffSetWithKeybaordHidden() {
        RxKeyboard.instance.isHidden
            .filter { $0 }
            .drive(onNext: { [scrollView] _ in
                scrollView?.contentOffset.y += 0
                scrollView?.contentInset.bottom = 0
        }).disposed(by: disposeBag)
    }
    
    private func bindLoginDidTappedWithLoginButtonTap() {
        guard let viewModel = presenter?.viewModel else { return }
        loginButton.rx.tap
            .bind(to: viewModel.loginDidTapped)
            .disposed(by: disposeBag)
    }
    
    private func bindSignupDidTappedWithSignupButtonTap() {
        guard let viewModel = presenter?.viewModel else { return }
        signupButton.rx.tap
            .bind(to: viewModel.signupDidTapped)
            .disposed(by: disposeBag)
    }
    
    private func bindEmailTextSubjectWithEmailTextField() {
        guard let viewModel = presenter?.viewModel else { return }
        emailTextField.rx.text.compactMap { $0 }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
    }
    
    private func bindPasswordTextSubjectWithEmailTextField() {
        guard let viewModel = presenter?.viewModel else { return }
        passwordTextField.rx.text.compactMap { $0 }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
    }
    
    private func bindFirstNameTextSubjectWithEmailTextField() {
        guard let viewModel = presenter?.viewModel else { return }
        firstNameTextField.rx.text.compactMap { $0 }
            .bind(to: viewModel.firstName)
            .disposed(by: disposeBag)
    }
    
    private func bindLastNameTextSubjectWithEmailTextField() {
        guard let viewModel = presenter?.viewModel else { return }
        lastNameNameTextField.rx.text.compactMap { $0 }
            .bind(to: viewModel.lastName)
            .disposed(by: disposeBag)
    }
    
    private func bindBirthDateTextSubjectWithBirthdataTextField() {
        guard let viewModel = presenter?.viewModel else { return }
        birthDateTextField.rx.text.compactMap { $0 }
            .bind(to: viewModel.birthDate)
            .disposed(by: disposeBag)
    }
    
    private func bindAgrementAgreeSwitchSubjectWithAgrementAgreeSwitch() {
        guard let viewModel = presenter?.viewModel else { return }
        agrementAgreeSwitch.rx.value
            .bind(to: viewModel.agrementAgreeSwitch)
            .disposed(by: disposeBag)
    }
    
    
}

extension SignupViewController {
    
    private func handleTextFieldsDidEndEditing() {
        handleEmailTextFieldDidEndEditing()
        handlePasswordTextFieldDidEndEditing()
        handleFirstNameTextFieldDidEndEditing()
        handleLastNameTextFieldDidEndEditing()
    }
    
    private func handleEmailTextFieldDidEndEditing() {
        emailTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.passwordTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    private func handlePasswordTextFieldDidEndEditing() {
        passwordTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.firstNameTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    private func handleFirstNameTextFieldDidEndEditing() {
        firstNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.lastNameNameTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    private func handleLastNameTextFieldDidEndEditing() {
        lastNameNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.birthDateTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
    }
}

//MARK: - Display
extension SignupViewController: SignupViewControllerProtocol {
    func displayAlertWith(title: String?, message: String?) {
        showDefaultAlert(title: title, message: message, okTitle: presenter?.viewModel.localization.ok)
    }
}

//MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == birthDateTextField {
            if birthDateTextField.text?.count == 2 || birthDateTextField.text?.count == 5 {
                if !(string == "") {
                    birthDateTextField.text = birthDateTextField.text! + "."
                }
            }
            // check the condition not exceeds 9 chars
            return !(birthDateTextField.text!.count > 9 && (string.count ) > range.length)
        } else {
            return true
        }
    }
}
