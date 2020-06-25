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

class WalletTransactionsViewController: UIViewController {

    
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
        addRefreshControlToTableView()
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(TransactionCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(TransactionCell.self)")
    }
    
    private func registerTableViewHeaderView() {
        tableView.register(TransactionTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "\(TransactionTableViewHeaderView.self)")
    }
    
    private func setupTableViewRowHeight() {
        tableView.rowHeight = 62
    }
    
    private func setupTableViewDelegate() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupTableViewBackgroundColor() {
        tableView.backgroundColor = .white
    }
    
    private func addRefreshControlToTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        tableView.refreshControl = refreshControl
    }
}

//MARK: - UI Binding
extension WalletTransactionsViewController {
    
    private func configuireUIBinding() {
        bindTransactionTableViewDatasource()
        bindBalanceLabelTextWithUserBalannce()
        bindReloadTransactionsWithRefreshControlPulled()
    }
    
    private func bindTransactionTableViewDatasource() {
        let dataSource = RxTableViewSectionedReloadDataSource<CategorizedTransaction>(
            configureCell: { (_, tv, indexPath, model) in
                let cell = tv.dequeueReusableCell(withIdentifier:
                    "\(TransactionCell.self)") as? TransactionCell ?? TransactionCell()
                cell.updateUI(with: model)
                return cell
            })
        
        presenter?.viewModel.transactionsDatasource
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindBalanceLabelTextWithUserBalannce() {
        presenter?.viewModel.userBalance
            .bind(to: walletHeaderView.balanceLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindReloadTransactionsWithRefreshControlPulled() {
        guard let viewModel = presenter?.viewModel else { return }
        tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .bind(to: viewModel.reloadFetchingTransactions)
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

extension WalletTransactionsViewController: WalletTransactionsViewControllerProtocol {

    func displayEmptyTransactionsView() {
        setupEmptyTransactionsView()
    }
    
    private func setupEmptyTransactionsView() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = presenter?.viewModel.localization.emptyTransactions
        titleLabel.center = tableView.center
        tableView.backgroundView = titleLabel
    }
    
    func removeEmptyTransactionsView() {
        tableView.backgroundView = nil
    }
    
    func stopAnimatingRefreshControl() {
        tableView.refreshControl?.endRefreshing()
    }
}
