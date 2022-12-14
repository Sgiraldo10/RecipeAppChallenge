//
//  RESTClientTest.swift
//  NetworkModuleTests
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import XCTest

@testable import NetworkModule

final class RESTClientTest: XCTestCase {
    private enum Constant {
        static let validBaseURL = "https://google.com/sites/MLA/"
        static let invalidBaseURL = "@#$%^&*"
    }

    private var cancellable = Set<AnyCancellable>()
    private var sut: RESTClientType!

    override func setUp() {
        super.setUp()
        sut = RESTClient(baseURL: Constant.validBaseURL)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInit_GivenBaseURL_ThenSeTBaseURL() {
        XCTAssertEqual(sut.baseURL, Constant.validBaseURL)
    }

    func testRequest_GivenInvalidBaseURL_ThenReturnInvalidPathError() {
        let endpoint = RESTEndpoint(method: .get, relativePath: "search", params: [:])
        let expectation = XCTestExpectation(description: "Waiting for request response.")

        sut = RESTClient(baseURL: Constant.invalidBaseURL)

        sut.requestTo(endpoint: endpoint, model: String.self).sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    switch error {
                    case .invalidPath(message: let message):
                        XCTAssertTrue(true, "Error: \(message)")
                    default:
                        XCTFail()
                    }
                }

                expectation.fulfill()
            },
            receiveValue: { (_: String) in }).store(in: &cancellable)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequest_GivenInvalidParams_WhenIsURLEncodedContentType_ThenReturnInvalidParamsError() {
        let invalidParams: [String: Any] = ["Param1": 12, "Param2": true]
        let endpoint = RESTEndpoint(method: .get, relativePath: "search", params: invalidParams, contentType: .URLEncoded)
        let expectation = XCTestExpectation(description: "Waiting for request response.")

        sut.requestTo(endpoint: endpoint, model: String.self).sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    switch error {
                    case .invalidParams(message: let message):
                        XCTAssertTrue(true, "Error: \(message)")
                    default:
                        XCTFail()
                    }
                }

                expectation.fulfill()
            },
            receiveValue: { (_: String) in }).store(in: &cancellable)

        wait(for: [expectation], timeout: 1.0)
    }
}
