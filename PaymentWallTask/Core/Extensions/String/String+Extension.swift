//
//  String+Extension.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/25/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String = Date.displayFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

extension String {
    func validateWith(pattern: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return validateWith(pattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
    }

    var isEmail: Bool {
        return validateWith(pattern:"^(.+)@(.+)$")
    }

    var isValidName: Bool {
        return validateWith(pattern: "^.{1,20}$")
    }
}
