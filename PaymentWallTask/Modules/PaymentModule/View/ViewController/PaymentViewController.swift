//
//  PaymentViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit
import RxSwift
import RxCocoa

class PaymentViewController: UIViewController, PaymentViewControllerProtocol {

    
    //MARK: - Outlets
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var amountToPayLabel: UILabel!
    @IBOutlet weak var userBalanceLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    //MARK:- Views
    private var paymentSuccessedView: PaymentSuccessedView?
    
    
    //MARK: - Attributes
	var presenter: PaymentPresenterProtocol?
    let disposeBag = DisposeBag()

    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configuireBinding()
        presenter?.attach()        
    }

}

//MARK: - UI Setup
extension PaymentViewController {
    
    private func setupUI() {
        updateLabelsWithTransaction()
        setupNavigationBarUI()
    }
    
    private func updateLabelsWithTransaction() {
        guard let transaction = presenter?.viewModel.transaction,
            let localization = presenter?.viewModel.localization
            else { return }
        businessNameLabel.text = transaction.businessName
        amountToPayLabel.text = "\(transaction.paymentAmount) \(transaction.currency?.rawValue ?? "")"
        payButton.setTitle("\(localization.pay) \(transaction.paymentAmount) \(transaction.currency?.rawValue ?? "")", for: .normal)
    }
    
    private func setupNavigationBarUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        let backButton = UIBarButtonItem()
        backButton.tintColor = .white
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.view.backgroundColor = .clear
        navigationItem.title = presenter?.viewModel.localization.payment
    }
}

//MARK: - UI Binding
extension PaymentViewController {
    
    private func configuireBinding() {
        bindPayButtonTap()
        bindUserBalanceLabelTextWithUserBalance()
    }
    
    private func bindPayButtonTap() {
        guard let viewModel = presenter?.viewModel else { return }
        payButton.rx.tap
            .bind(to: viewModel.payButtonTap)
            .disposed(by: disposeBag)
    }
    
    private func bindUserBalanceLabelTextWithUserBalance() {
        presenter?.viewModel.userBalance
            .bind(to: userBalanceLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

//MARK: - Display
extension PaymentViewController {
    
    func displayPaymentSuccessedView() {
        setupPaymentSuccessedView()
    }
    
    private func setupPaymentSuccessedView() {
        paymentSuccessedView = PaymentSuccessedView()
        guard let paymentSuccessedView = paymentSuccessedView else { return }
        paymentSuccessedView.attachPresenter(presenter)
        view.addSubview(paymentSuccessedView)
        paymentSuccessedView.addCenterConstraints(vertical: view.centerYAnchor, horizontal: view.centerXAnchor)
        let viewSize = view.bounds.size
        //adjust constraints for small sizes
        paymentSuccessedView.addWidthConstraints(width: 307 > viewSize.width ? viewSize.width * 0.8 : 307)
        paymentSuccessedView.addHeightConstraints(height: 426 > viewSize.height ? viewSize.height : 426)
    }
    
    func removePaymentSuccessedView() {
        paymentSuccessedView?.removeFromSuperview()
    }
    
    func displayAlertWith(title: String?, message: String) {
        showDefaultAlert(title: title, message: message, okTitle: presenter?.viewModel.localization.ok)
    }
}
