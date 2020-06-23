//
//  QRCodeScannerViewModel.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift
import RxCocoa

struct QRCodeScannerViewModel {
    
    let didCaptureString = PublishSubject<String>()
    let transaction = PublishRelay<Transaction>()
    let paymentConfirmed = PublishSubject<Bool>()
    
    let localization =  QRCodeScannerLocalization()
}
