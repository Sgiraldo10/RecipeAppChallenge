//
//  BaseViewControllerType.swift
//
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import UIKit

public protocol BaseViewControllerType: ViewControllerBindable, ErrorShowable, ProgressShowable {
    associatedtype PresenterType
    associatedtype ViewType

    var presenter: PresenterType { get }
    var customView: ViewType { get }
}

public protocol ErrorShowable {
    func presentError(_ error: InterfaceError)
}

public protocol ProgressShowable {
    func showProgress()
    func hideProgress()
}
