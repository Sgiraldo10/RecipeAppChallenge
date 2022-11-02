//
//  ProxyApplicationTests.swift
//  ProxyApplicationTests
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import NetworkModule
import XCTest

@testable import EmpowermentsLabsChallenge

final class ApplicationCoordinatorTest: XCTestCase {
    private var sut: ApplicationCoordinator!
    private var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = ApplicationCoordinator(window: window, restClient: RESTClient(baseURL: "testURL"))
    }

    override func tearDown() {
        sut = nil
        window = nil
        super.tearDown()
    }

    func testStart_WhenIsCalled_ThenSetApplicationViewController() {
        sut.start()
        guard let module = sut.navigationController.viewControllers.first else {
            XCTFail()
            return
        }

        XCTAssertTrue(module is ApplicationViewControllerType)
    }

    func testStart_WhenIsCalled_ThenHideNavigationBar() {
        sut.start()
        XCTAssertTrue(sut.navigationController.isNavigationBarHidden)
    }

    func testStart_WhenIsCalled_ThenSetWindowRootViewController() {
        sut.start()
        XCTAssertEqual(window.rootViewController, sut.navigationController)
    }
}
