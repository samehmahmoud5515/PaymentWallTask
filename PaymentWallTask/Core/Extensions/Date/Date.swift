//
//  Date.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/25/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

extension Date {
    func toForamt(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static let transactionDisplayFormat = "dd.MM.yyyy"
}
