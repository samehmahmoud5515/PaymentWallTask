//
//  WalletTransactionsContract.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import Foundation
import RxSwift


//MARK: - Router
enum WalletTransactionsRoute {
}

protocol WalletTransactionsRouterProtocol: class {
    func go(to route:WalletTransactionsRoute)
}



//MARK: - Presenter
protocol WalletTransactionsPresenterProtocol: class {
    func attach()
    var viewModel: WalletTransactionsViewModel  { get }

}



//MARK: - Interactor
protocol WalletTransactionsInteractorProtocol: class {

    
}



//MARK: - View
protocol WalletTransactionsViewControllerProtocol: class {
    
    var presenter: WalletTransactionsPresenterProtocol?  { get set }
}
