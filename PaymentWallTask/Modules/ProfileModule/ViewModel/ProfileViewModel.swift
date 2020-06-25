//
//  ProfileViewModel.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import RxSwift

struct ProfileViewModel {
    
    let user = PublishSubject<User>()
    
    //taps
    let logoutButtonDidTap = PublishSubject<Void>()
    
    let localization =  ProfileLocalization()
}
