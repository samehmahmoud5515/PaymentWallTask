//
//  HomeContract.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import Foundation
import RxSwift


//MARK: - Router
enum HomeRoute {
}

protocol HomeRouterProtocol: class {
    func go(to route:HomeRoute)
}



//MARK: - Presenter
protocol HomePresenterProtocol: class {
    func attach()
    var viewModel: HomeViewModel  { get }

}



//MARK: - Interactor
protocol HomeInteractorProtocol: class {

    
}



//MARK: - View
protocol HomeViewControllerProtocol: class {

    var presenter: HomePresenterProtocol?  { get set }
}
