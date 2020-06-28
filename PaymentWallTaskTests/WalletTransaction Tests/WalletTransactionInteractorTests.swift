//
//  WalletTransactionInteractorTests.swift
//  PaymentWallTaskTests
//
//  Created by SAMEH on 6/19/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import RxSwift
import XCTest
@testable import PaymentWallTask

class WalletTransactionInteractorTests: XCTestCase {
    
    var interactor: WalletTransactionsInteractor!
    var tranasactions: [Transaction]!
    
    override func setUp() {
        interactor = WalletTransactionsInteractor()
        tranasactions = [Transaction]()
    }
    
    func testEmptyTransactions() throws {
        XCTAssertEqual(interactor.cateogrizeTransactionWithDate(transactions: tranasactions).count, 0)
    }
    
    func testAppendingWrongTransaction() throws {
        var transaction = Transaction()
        transaction.paymentAmount = 1.0
        transaction.currency = nil
        tranasactions.append(transaction)
        let catTransactions = interactor.cateogrizeTransactionWithDate(transactions: tranasactions).first
        XCTAssertNil(catTransactions)
    }
    
    func testAppedningOneTransaction() throws {
        var transaction1 = Transaction()
        transaction1.paymentAmount = 1.0
        transaction1.currency = Currency.USD
        transaction1.date = Date()
        transaction1.businessName = "Test"
        
        tranasactions.append(transaction1)
        let catTransactions = interactor.cateogrizeTransactionWithDate(transactions: tranasactions).first?.header
        XCTAssertNotNil(catTransactions)
    }
    
    func testAppendingMultipleTransactions() throws {
        var transaction1 = Transaction()
        transaction1.paymentAmount = 1.0
        transaction1.currency = Currency.USD
        transaction1.date = Date()
        transaction1.businessName = "Test"
        
        var transaction2 = Transaction()
        transaction2.paymentAmount = 1.0
        transaction2.currency = Currency.USD
        transaction2.date = Date().addingTimeInterval(100000)
        transaction2.businessName = "Test"
        
        tranasactions.append(transaction1)
        tranasactions.append(transaction2)
        
        let catTransactions = interactor.cateogrizeTransactionWithDate(transactions: tranasactions)
        XCTAssertEqual(catTransactions.count, 2)
    }
    
    func testAppendingMultipleTransactionsOneIsWrong() throws {
        var transaction1 = Transaction()
        transaction1.paymentAmount = 1.0
        transaction1.currency = Currency.USD
        transaction1.date = Date()
        transaction1.businessName = "Test"
        
        var transaction2 = Transaction()
        transaction2.paymentAmount = 1.0
        transaction2.currency = Currency.USD
        transaction2.date = nil
        transaction2.businessName = "Test"
        
        tranasactions.append(transaction1)
        tranasactions.append(transaction2)
        
        let catTransactions = interactor.cateogrizeTransactionWithDate(transactions: tranasactions)
        XCTAssertEqual(catTransactions.count, 1)
    }
    
    

}
