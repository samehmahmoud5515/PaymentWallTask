//
//  LoginTests.swift
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

class LoginTests: XCTestCase {

    var subject: LoginViewModel!
    var testScheduler: TestScheduler!
    var disposBag: DisposeBag!
    var loginStubs: LoginViewModelStub!
    
    override func setUp() {
        super.setUp()
        subject = LoginViewModel()
        testScheduler = TestScheduler(initialClock: 0)
        disposBag = DisposeBag()
        loginStubs = LoginViewModelStub()
    }
    
    override func tearDown() {
        super.tearDown()
        testScheduler = nil
        subject = nil
    }

    func test() throws {
        let buttonTap = PublishSubject<Void>()
        buttonTap.bind(to: subject.loginDidTapped)
            .disposed(by: disposBag)
        
        let loginStubs = LoginViewModelStub()
        var results: (String, String)!

        let combinedObs = Observable.combineLatest(subject.emailText, subject.passwordText)
        
        buttonTap.withLatestFrom(combinedObs).subscribe(onNext: { args in
            results = args
        }).disposed(by: disposBag)
        
        subject.emailText.onNext(loginStubs.args.0)
        subject.passwordText.onNext(loginStubs.args.1)
        
        buttonTap.onNext(())
        
        XCTAssertEqual(results.0, loginStubs.args.0)
        XCTAssertEqual(results.1, loginStubs.args.1)
    }

    func testBindingTapWithLatestInputs() {
        let emailPasswordObs = Observable.combineLatest(subject.emailText, subject.passwordText)
        let obs = subject.loginDidTapped.withLatestFrom(emailPasswordObs)
        let result = try? obs.toBlocking().first()
        
        let expectedResult: (String, String) = ("sam", "1234")
        subject.emailText.onNext(expectedResult.0)
        subject.emailText.onNext(expectedResult.1)
        subject.loginDidTapped.onNext(())
        
        if let result = result {
            XCTAssertEqual(result.0, expectedResult.0)
            XCTAssertEqual(result.1, expectedResult.1)
        }
    }
    
   

}

class LoginViewModelStub {
    
    var args: (String, String) = ("ss@s.com", "1234567Aa")
}

func ==(lhs: (String, String), rhs: (String, String)) -> Bool {
    return lhs.0 == rhs.0 && lhs.1 == rhs.1
}

