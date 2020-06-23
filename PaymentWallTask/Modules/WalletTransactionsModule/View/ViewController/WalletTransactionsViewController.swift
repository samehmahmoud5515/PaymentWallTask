//
//  WalletTransactionsViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit
import RxSwift
import RxDataSources

class WalletTransactionsViewController: UIViewController, WalletTransactionsViewControllerProtocol {

    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var walletHeaderView: WalletHeaderView!
    
    
    //MARK: - Attributes
	var presenter: WalletTransactionsPresenterProtocol?
    let disposeBag = DisposeBag()
    
    
    //MARK: -  View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configuireUIBinding()
        presenter?.attach()
    }
    
}

//MARK: - UI Setup
extension WalletTransactionsViewController {
    
    private func setupUI() {
        registerTableViewCell()
        registerTableViewHeaderView()
        setupTableViewRowHeight()
        setupTableViewDelegate()
        setupTableViewBackgroundColor()
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(TransactionCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(TransactionCell.self)")
    }
    
    private func registerTableViewHeaderView() {
        tableView.register(TransactionTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "\(TransactionTableViewHeaderView.self)")
    }
    
    private func setupTableViewRowHeight() {
        tableView.rowHeight = 70
    }
    
    private func setupTableViewDelegate() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupTableViewBackgroundColor() {
        tableView.backgroundColor = .white
    }
}

//MARK: - UI Binding
extension WalletTransactionsViewController {
    
    private func configuireUIBinding() {
        bindTransactionTableViewDatasource()
    }
    
    private func bindTransactionTableViewDatasource() {
        let dataSource = RxTableViewSectionedReloadDataSource<CategorizedTransaction>(
            configureCell: { (_, tv, indexPath, model) in
                let cell = tv.dequeueReusableCell(withIdentifier:
                    "\(TransactionCell.self)") as? TransactionCell ?? TransactionCell()
            
                return cell
            })
        
        presenter?.viewModel.transactionsDatasource
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

//MARK: - UITableViewDelegate
extension WalletTransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(TransactionTableViewHeaderView.self)") as? TransactionTableViewHeaderView ?? TransactionTableViewHeaderView()
        guard let datasource = presenter?.viewModel.transactionsDatasource else { return headerView }
        if let title = try? datasource.value()[section].header {
            headerView.updateTitle(title)
        }
        return headerView
    }
}
