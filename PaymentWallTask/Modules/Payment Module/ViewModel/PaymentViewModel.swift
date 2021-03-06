//
//  PaymentViewModel.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift
import RxCocoa

struct PaymentViewModel {
    
    let transaction: Transaction
    
    //taps
    let payButtonTap = PublishRelay<Void>()
    let transactionSuccessOkButtonTap = PublishRelay<Void>()
    let userBalance = PublishSubject<String>()
    
    //errors
    let errorDidHappendWhilePayment = PublishSubject<Error>()
    
    //localiztion
    let localization = PaymentLocalization()
    
}
