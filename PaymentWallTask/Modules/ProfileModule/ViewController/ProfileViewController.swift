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
    
    
    
    //MARK: - Attributes
	var presenter: ProfilePresenterProtocol?
    let disposeBag = DisposeBag()

    
    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach()
    }
    
    

    
    //MARK: - Display
    
}
