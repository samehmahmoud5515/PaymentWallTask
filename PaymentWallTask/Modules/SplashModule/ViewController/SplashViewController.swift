//
//  SplashViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/24/20.
//
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController, SplashViewControllerProtocol {
    
    //MARK: - Outlets
    
    
    
    //MARK: - Attributes
	var presenter: SplashPresenterProtocol?
    let disposeBag = DisposeBag()

    
    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach()
    
    }
    

    
}
