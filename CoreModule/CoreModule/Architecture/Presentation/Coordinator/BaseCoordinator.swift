//
//  BaseCoordinator.swift
//  
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import UIKit

open class BaseCoordinator: CoordinatorType {
    public var parentCoordinator: CoordinatorType?
    public var navigationController: UINavigationController

    public init(parentCoordinator: CoordinatorType? = nil, navigationController: UINavigationController = UINavigationController()) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }

    open func start() {}

    public func childDeinitialized(_ child: CoordinatorType) {
        print(child)
    }

    deinit {
        parentCoordinator?.childDeinitialized(self)
    }
}
