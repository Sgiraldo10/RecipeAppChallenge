//
//  ApplicationCoordinatorType.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public protocol ApplicationCoordinatorType: ProductListCoordinatorType {
    func runProductListModule()
}

public protocol ProductListCoordinatorType: CoordinatorType {
    func runProductDetailModule(for product: Any)
}
