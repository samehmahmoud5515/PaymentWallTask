//
//  PaymentSuccessedView.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/23/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import UIKit
import RxSwift

class PaymentSuccessedView: UIView {

    //MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var transactionCodeLabel: UILabel!
    
    //MARK: - Attribuites
    private var presenter: PaymentPresenterProtocol?
    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        nibSetup()
    }
    
    private func nibSetup() {
        Bundle.main.loadNibNamed("\(PaymentSuccessedView.self)",
                                 owner: self, options: nil)
        guard let contentView = contentView else { return }
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    func attachPresenter(_ presenter: PaymentPresenterProtocol?) {
        self.presenter = presenter
        setupUI()
        configuireBinding()
    }
}

//MARK: - UI Setup
extension PaymentSuccessedView {
    
    private func setupUI() {
        setupTransactionCodeLabelText()
    }
    
    private func setupTransactionCodeLabelText() {
        transactionCodeLabel.text = presenter?.genrateRandomString(of: 10)
    }
}


//MARK: - UI Binding
extension PaymentSuccessedView {
    
    private func configuireBinding() {
        bindOkButtonTap()
    }
    
    private func bindOkButtonTap() {
        guard let viewModel = presenter?.viewModel else { return }
        okButton.rx.tap.bind(to: viewModel.transactionSuccessOkButtonTap)
            .disposed(by: disposeBag)
    }
}
