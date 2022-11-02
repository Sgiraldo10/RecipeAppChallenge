//
//  ApplicationCoordinatorSpy.swift
//  ProxyApplicationTests
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule

final class ApplicationCoordinatorSpy: ApplicationCoordinatorType {
    var runProductListModuleCallBack: (() -> Void)?
    var runProductDetailModuleCallBack: (() -> Void)?

    func runProductListModule() {
        runProductListModuleCallBack?()
    }

    func runProductDetailModule(for _: Any) {
        runProductDetailModuleCallBack?()
    }

    func start() {
        preconditionFailure("Implement this to use it.")
    }

    func childDeinitialized(_: CoordinatorType) {
        preconditionFailure("Implement this to use it.")
    }
}
