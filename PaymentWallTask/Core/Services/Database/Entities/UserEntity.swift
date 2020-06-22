//
//  UserEntity.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/22/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RealmSwift

class UserEntity: Object {
    
    @objc dynamic var email: String = ""
    @objc dynamic var mobile: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var balance: String = ""
    
}

