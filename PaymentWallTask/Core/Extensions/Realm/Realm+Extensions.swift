//
//  Realm+Extensions.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/22/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            beginWrite()
            try block()
            try commitWrite()
        } else {
            try write(block)
        }
    }
}
