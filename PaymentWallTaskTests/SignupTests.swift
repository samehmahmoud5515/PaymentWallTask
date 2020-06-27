//
//  SignupTests.swift
//  PaymentWallTaskTests
//
//  Created by SAMEH on 6/26/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest
import RxBlocking

@testable import PaymentWallTask

class SignupTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
      viewModel = LoginViewModel()
      scheduler = TestScheduler(initialClock: 0)
      disposeBag = DisposeBag()
    }
    
    

    func testNumeratorStartsAt4() throws {
        viewModel.emailText.onNext("")
        let obs = try viewModel.emailText.toBlocking().first()
        viewModel.emailText.onNext("")
        XCTAssertEqual(obs, "")
        //XCTAssertEqual(try viewModel.numeratorText.toBlocking().first(), "4")
        //XCTAssertEqual(try viewModel.numeratorValue.toBlocking().first(), 4)
    }
    
    func testTappedPlayPauseChangesIsPlaying() {
        let isTapped = scheduler.createObserver(Void.self)
        let email = scheduler.createObserver(String.self)
        let password = scheduler.createObserver(String.self)

        viewModel.loginDidTapped
            .asDriver(onErrorJustReturn: ())
            .drive(isTapped)
           // .bind(to: isTapped)
            .disposed(by: disposeBag)

      scheduler.createColdObservable([.next(10, ()),
                                      .next(20, ()),
                                      .next(30, ())])
               .bind(to: viewModel.loginDidTapped)
               .disposed(by: disposeBag)

      scheduler.start()

//      XCTAssertEqual(isTapped.events, [
//        .next(0, false),
//        .next(10, true),
//        .next(20, false),
//        .next(30, true)
//      ])
        
    }

}
