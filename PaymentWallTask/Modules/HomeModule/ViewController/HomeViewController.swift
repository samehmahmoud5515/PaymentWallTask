//
//  HomeViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UITabBarController, HomeViewControllerProtocol {

    
    //MARK: - Attributes
	var presenter: HomePresenterProtocol?
    
    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach()
        setupUI()
    }
    
}

//MARK: - UI Setup
extension HomeViewController {
    
    private func setupUI() {
        setupNavigationBarStyle()
        setupTabBarStyle()
    }

    private func setupNavigationBarStyle() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.isNavigationBarHidden = true
        navigationController?.tabBarController?.tabBar.barStyle = .default
        setNeedsStatusBarAppearanceUpdate()
    }
       
    private func setupTabBarStyle() {
        tabBar.barTintColor = .white
        tabBar.barStyle = .default
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.tintColor = .lightningYellow
    }
    
}
