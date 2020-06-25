//
//  LoginContract.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/22/20.
//
//

import Foundation
import RxSwift


//MARK: - Router
enum LoginRoute {
    case home
    case signup
}

protocol LoginRouterProtocol: class {
    func go(to route:LoginRoute)
}



//MARK: - Presenter
protocol LoginPresenterProtocol: class {
    func attach()
    var viewModel: LoginViewModel  { get }

}



//MARK: - Interactor
protocol LoginInteractorProtocol: LoginProtocol {

}



//MARK: - View
protocol LoginViewControllerProtocol: class {

    var presenter: LoginPresenterProtocol?  { get set }
    func displayAlertWith(title: String?, message: String?)
}
