//
//  SignupValidationTests.swift
//  PaymentWallTaskTests
//
//  Created by SAMEH on 6/28/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

import XCTest
@testable import PaymentWallTask

class SignupValidationTests: XCTestCase {
    
    
    override func setUp() {
        
    }
    
    func testNotValidEmail() throws {
        XCTAssertEqual("ss".isEmail, false)
    }
    
    func testIsValidEmail() throws {
        XCTAssertEqual("ss@s.com".isEmail, true)
    }
    
    func testNotValidPassword1() throws {
        XCTAssertEqual("ss".isValidPassword, false)
    }
    
    func testNotValidPassword2() throws {
        XCTAssertEqual("asdsfafsda".isValidPassword, false)
    }
    
    func testNotValidPassword3() throws {
        XCTAssertEqual("11111111".isValidPassword, false)
    }
    
    func testNotValidPassword4() throws {
        XCTAssertEqual("11111111A".isValidPassword, false)
    }
    
    func testIsValidPassword1() throws {
        XCTAssertEqual("123456Aa".isValidPassword, true)
    }
    
    func testIsValidPassword2() throws {
        XCTAssertEqual("aaaaaaA1".isValidPassword, true)
    }
    
    func testIsValidName() throws {
        XCTAssertEqual("aaaaaaA1".isValidName, true)
    }
    
    func testNotValidDate1() throws {
        XCTAssertNil("10".toDate())
    }
    
    func testNotValidDate2() throws {
        XCTAssertNil("10.12".toDate())
    }
    
    func testValidDate() throws {
        XCTAssertNotNil("10.12.1990".toDate())
    }
}
