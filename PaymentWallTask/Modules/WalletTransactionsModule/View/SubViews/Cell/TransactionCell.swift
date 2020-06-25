//
//  TransactionCell.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/23/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var businnessTitleLabel: UILabel!
    @IBOutlet weak var paymentAmountLabel: UILabel!
    
}

extension TransactionCell {
    
    func updateUI(with transaction: Transaction) {
        businnessTitleLabel.text = transaction.businessName
        paymentAmountLabel.text = "\(transaction.paymentAmount) \(transaction.currency?.rawValue ?? "")"
    }
}
