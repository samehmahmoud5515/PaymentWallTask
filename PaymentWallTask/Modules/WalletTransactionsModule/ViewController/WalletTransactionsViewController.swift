//
//  WalletTransactionsViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit
import RxSwift
import RxCocoa

class WalletTransactionsViewController: UIViewController, WalletTransactionsViewControllerProtocol {

    
    
    //MARK: - Outlets
    
    
    
    //MARK: - Attributes
	var presenter: WalletTransactionsPresenterProtocol?
    let disposeBag = DisposeBag()

    
    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach()
    }
    
    
    
    
    //MARK: - Display
    
}
