//
//  LoginViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/22/20.
//
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxGesture

class LoginViewController: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    //MARK: - Attributes
	var presenter: LoginPresenterProtocol?
    let disposeBag = DisposeBag()
    
    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUIBinding()
        presenter?.attach()
    }
    
}

//MARK: - UI Setup
extension LoginViewController {
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
    }
}

//MARK: - UI Binding
extension LoginViewController {
    
    private func configureUIBinding() {
        bindScrollViewContentOffSetWithKeybaordVisiable()
        bindbindScrollViewContentOffSetWithKeybaordHidden()
        bindLoginDidTappedWithLoginButtonTap()
        bindSignupDidTappedWithSignupButtonTap()
        handleEmailTextFieldDidEndEditing()
        handlePasswordTextFieldDidEndEditing()
        handlePasswordTextFieldDidEndEditing()
        bindEmailTextSubjectWithEmailTextField()
        bindPasswordTextSubjectWithPasswordTextField()
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
    
    private func handleEmailTextFieldDidEndEditing() {
        emailTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.passwordTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    private func handlePasswordTextFieldDidEndEditing() {
        passwordTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.dismissKeyboard()
            }).disposed(by: disposeBag)
    }
    
    private func bindEmailTextSubjectWithEmailTextField() {
        guard let viewModel = presenter?.viewModel else { return }
        emailTextField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
    }
    
    private func bindPasswordTextSubjectWithPasswordTextField() {
        guard let viewModel = presenter?.viewModel else { return }
        passwordTextField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)
    }
}

//MARK: - Display
extension LoginViewController: LoginViewControllerProtocol {
    func displayAlertWith(title: String?, message: String?) {
        showDefaultAlert(title: title, message: message, okTitle: presenter?.viewModel.localization.ok)
    }
}
