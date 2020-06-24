//
//  SplashContract.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/24/20.
//
//

import RxSwift


//MARK: - Router
enum SplashRoute {
    case login
    case home
}

protocol SplashRouterProtocol: class {
    func go(to route:SplashRoute)
}



//MARK: - Presenter
protocol SplashPresenterProtocol: class {
    func attach()
    var viewModel: SplashViewModel  { get }

}



//MARK: - Interactor
protocol SplashInteractorProtocol: class {
    var isThereLoggedUser: Bool { get }
}



//MARK: - View
protocol SplashViewControllerProtocol: class {

    var presenter: SplashPresenterProtocol?  { get set }
  
}
