//
//  QRCodeScannerInteractorTest.swift
//  PaymentWallTaskTests
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest
import RxBlocking

@testable import PaymentWallTask

class QRCodeScannerInteractorTest: XCTestCase {

    var subject: QRCodeScannerInteractor!
    
    override func setUp() {
        super.setUp()
        subject = QRCodeScannerInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        subject = nil
    }

    func testParseValidJsonStub() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "QRCodeStub", ofType: "json") else {
            XCTFail("json not found")
            return
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            XCTFail("Unable to convert json to String")
            return
        }
        let transaction = Transaction(JSONString: jsonString)
        
        XCTAssertNotNil(transaction)
    }
    
    func testParseNotValidJsonStub() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "QRCodeWrongStub", ofType: "json") else {
            XCTFail("json not found")
            return
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            XCTFail("Unable to convert json to String")
            return
        }
        let transaction = Transaction(JSONString: jsonString)
        
        XCTAssertNil(transaction)
    }



}
