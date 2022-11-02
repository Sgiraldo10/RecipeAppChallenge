//
//  ProductListCoordinatorSpy.swift
//  EmpowermentsLabsChallengeTests
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule

@testable import EmpowermentsLabsChallenge

final class ProductListCoordinatorSpy: ProductListCoordinatorType {
    var runProductDetailModuleCalled = false

    func runProductDetailModule(for product: Any) {
        self.runProductDetailModuleCalled = true
    }

    func start() {}

    func childDeinitialized(_ child: CoordinatorType) {}
}
