//
//  KeyChainService.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/24/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

fileprivate struct KeyChainKeys {
    let serviceName = "com.payment-wall.keys"
    let loggedInEmail = "payment_wall_loggedin_email"
}

class KeychainService {
    
    fileprivate let keychainKeys = KeyChainKeys()
    
    init() {}
    
    func storeLoggedInEmail(email: String) {
        save(key: keychainKeys.loggedInEmail, data: Data(email.utf8))
    }
    
    var loggedInEmail: String? {
        return loadData(key: keychainKeys.loggedInEmail)?.toString()
    }

}


extension KeychainService {
    
    private func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }
    
    private func loadData(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    func clear()  {
        let secItemClasses =  [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity,
        ]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
        
}

