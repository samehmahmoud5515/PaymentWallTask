//
//  PaymentWallTaskUITests.swift
//  PaymentWallTaskUITests
//
//  Created by SAMEH on 6/19/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import XCTest

class PaymentWallTaskUITests: XCTestCase {

    var app: XCUIApplication!
    var waitingUIDuration: Double!
    
    
    override func setUp() {
        app = XCUIApplication()
        waitingUIDuration = 2.0
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func openApp() {
        app.launch()
    }
    

    //Pre-condition: user logged in
    //Pre-condition: there is at least one transaction
    func testBussinessLabelExist() {
        openApp()
        
        let name = "bussiness_name_label_id"
        let label = app.staticTexts[name]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: waitingUIDuration, handler: nil)
    }
    
    //Pre-condition: user logged in
    //Pre-condition: there is at least one transaction
    func testLabelAmountExist() {
        openApp()
        
        let shortName = "amount_label_id"
        let label = app.staticTexts[shortName]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: waitingUIDuration, handler: nil)
    }
    
    //Pre-condition: user logged in
    //Pre-condition: there are no transactions
    func testDisplayEmptyTransactionLabel() {
        openApp()
        let shortName = "empty_transactions_label_id"
        let label = app.staticTexts[shortName]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: waitingUIDuration, handler: nil)
    }
    
}
