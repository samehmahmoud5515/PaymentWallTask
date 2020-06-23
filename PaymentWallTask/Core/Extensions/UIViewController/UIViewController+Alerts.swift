//
//  UIViewController+Alerts.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/23/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

import UIKit

struct AlertButton {
    var title: String?
    var actionClosure: () -> Void
}

extension UIViewController {

    func showTwoActionsAlert(title:String?, message:String?, alertButtons: [AlertButton]) {
        
        guard alertButtons.count == 2 else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let titleTxt = NSMutableAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        
        alertController.setValue(titleTxt, forKey: "attributedTitle")
        
        alertController.view.tintColor = .lightningYellow
        
        let firstAlertAction = UIAlertAction(title: alertButtons[0].title, style: .default) { (_) in
            alertButtons[0].actionClosure()
        }
        
        let secondAlertAction = UIAlertAction(title:alertButtons[1].title, style: .default) { (_) in
            alertButtons[1].actionClosure()
        }
        
        alertController.addAction(secondAlertAction)
        alertController.addAction(firstAlertAction)
        
        present(alertController, animated: true) {
        }
    }
    
    func showDefaultAlert(title:String?, message:String?, okTitle: String?, actionBlock:(() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: okTitle, style: .default
        ) { _ in
            alertController.dismiss(animated: true) {
            }
            actionBlock?()
        }
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
        }
    }
}
