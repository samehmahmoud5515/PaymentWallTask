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
protocol LoginInteractorProtocol: class {

}



//MARK: - View
protocol LoginViewControllerProtocol: class {

    var presenter: LoginPresenterProtocol?  { get set }
}
