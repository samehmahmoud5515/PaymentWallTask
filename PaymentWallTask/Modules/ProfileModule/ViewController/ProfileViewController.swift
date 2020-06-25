//
//  ProfileViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    //MARK: - Outlets
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var birthDateStackView: UIStackView!
    @IBOutlet weak var birthDateSpearatorView: UIView!
    
    
    //MARK: - Attributes
	var presenter: ProfilePresenterProtocol?
    let disposeBag = DisposeBag()

    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuireUIBinding()
        presenter?.attach()
    }
    
    
}

//MARK: - UI binding
extension ProfileViewController {
    
    private func configuireUIBinding() {
        bindLogoutButtonDidTapWithLogoutTap()
        bindUserInfoViewsWithUser()
    }
    
    private func bindLogoutButtonDidTapWithLogoutTap() {
        guard let viewModel = presenter?.viewModel else { return }
        logoutButton.rx.tap
            .bind(to: viewModel.logoutButtonDidTap)
            .disposed(by: disposeBag)
    }
    
    private func bindUserInfoViewsWithUser() {
        presenter?.viewModel.user
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.updateUserInfo(with: user)
            }).disposed(by: disposeBag)
    }

}

extension ProfileViewController {
    private func updateUserInfo(with user: User) {
        emailLabel.text = user.email
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        let birthDate = user.birthDate?.toForamt()
        birthDateLabel.text = birthDate
        birthDateStackView.isHidden = birthDate == nil
        birthDateSpearatorView.isHidden = birthDate == nil
    }
}
