//
//  RootContract.swift
//  PaymentWallTask
//
//  Created by SAMEH on 6/19/20.
//  Copyright © 2020 sameh. All rights reserved.
//

import Foundation

enum RootRoute {
    case splash
}

protocol RootRouterProtocol: class {
    func go(to route:RootRoute)
}
