//
//  TransactionTableViewHeaderView.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/23/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import UIKit

class TransactionTableViewHeaderView: UITableViewHeaderFooterView {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .suvaGrey
        label.backgroundColor = .white
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setupContainerView()
        setupdateLabel()
    }
    
    private func setupContainerView() {
        backgroundColor = .white
        tintColor = .white
        contentView.tintColor = .white
        contentView.backgroundColor = .white
    }
    
    private func setupdateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.anchor(contentView.topAnchor, contentView.bottomAnchor, contentView.leadingAnchor, contentView.trailingAnchor, padding: nil)
    }
}

extension TransactionTableViewHeaderView {
    func updateTitle(_ title: String) {
        dateLabel.text = title
    }
}
