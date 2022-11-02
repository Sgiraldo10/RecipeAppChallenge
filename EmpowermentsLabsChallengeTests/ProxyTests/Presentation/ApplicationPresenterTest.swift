//
//  ApplicationPresenterTest.swift
//  ProxyApplicationTests
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import XCTest

@testable import EmpowermentsLabsChallenge

final class ApplicationPresenterTest: XCTestCase {
    private var sut: ApplicationPresenterType!
    private var coordinator: ApplicationCoordinatorSpy!

    override func setUp() {
        super.setUp()

        coordinator = ApplicationCoordinatorSpy()
        sut = ApplicationPresenter(
            dependencies: ApplicationPresenter.Dependencies(coordinator: coordinator))
    }

    override func tearDown() {
        coordinator = nil
        sut = nil
        super.tearDown()
    }

    func testViewDidLoad_WhenIsCalled_ThenRunProductListModule() {
        let expectation = XCTestExpectation(description: "Wait to run product list module")
        var isRunProductListModuleCalled = false

        coordinator.runProductListModuleCallBack = {
            isRunProductListModuleCalled = true
            expectation.fulfill()
        }

        sut.animationCompleted()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isRunProductListModuleCalled, "Run product list module.")
    }
}
