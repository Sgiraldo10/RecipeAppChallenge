//
//  ApplicationContract.swift
//  Application
//
//  Created Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import UIKit

protocol ApplicationViewControllerType: AnyObject {}

protocol ApplicationPresenterType: Bindable {
    func animationCompleted()
}

protocol ApplicationViewType: UIView {
    var logoImageView: UIImageView { get }
}
