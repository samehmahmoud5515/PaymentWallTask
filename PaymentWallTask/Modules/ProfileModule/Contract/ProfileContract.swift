//
//  ProfileContract.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import Foundation
import RxSwift


//MARK: - Router
enum ProfileRoute {
    case login
}

protocol ProfileRouterProtocol: class {
    func go(to route:ProfileRoute)
}



//MARK: - Presenter
protocol ProfilePresenterProtocol: class {
    func attach()
    var viewModel: ProfileViewModel  { get }

}



//MARK: - Interactor
protocol ProfileInteractorProtocol: LoginProtocol, UserInfoProtocol {

    
}



//MARK: - View
protocol ProfileViewControllerProtocol: class {

    var presenter: ProfilePresenterProtocol?  { get set }
}
