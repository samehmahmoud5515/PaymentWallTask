//
//  WalletHeaderView.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/23/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import UIKit

class WalletHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var balanceLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        nibSetup()
    }
    
    private func nibSetup() {
        Bundle.main.loadNibNamed("\(WalletHeaderView.self)",
                                 owner: self, options: nil)
        guard let contentView = contentView else { return }
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
}
