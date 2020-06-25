//
//  SignupContract.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/25/20.
//
//

import Foundation
import RxSwift


//MARK: - Router
enum SignupRoute {
    case login
    case home
}

protocol SignupRouterProtocol: class {
    func go(to route:SignupRoute)
}



//MARK: - Presenter
protocol SignupPresenterProtocol: class {
    func attach()
    var viewModel: SignupViewModel  { get }

}



//MARK: - Interactor
protocol SignupInteractorProtocol: SignupProtocol {

    
}



//MARK: - View
protocol SignupViewControllerProtocol: class {

    var presenter: SignupPresenterProtocol?  { get set }
    func displayAlertWith(title: String?, message: String?)
}
