//
//  SearchProductUseCaseTest.swift
//  EmpowermentsLabsChallengeTests
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Combine
import CoreModule
import NetworkModule
import XCTest

@testable import EmpowermentsLabsChallenge

final class SearchProductUseCaseTest: XCTestCase {
    private var sut: SearchProductUseCase!
    private var repositoryStub: ProductListRespositoryStub!

    override func setUp() {
        super.setUp()

        self.repositoryStub = ProductListRespositoryStub()
        self.sut = SearchProductUseCase(productListRepository: self.repositoryStub)
    }

    override func tearDown() {
        self.sut = nil
        self.repositoryStub = nil

        super.tearDown()
    }

    func testBuildUseCase_WhenIsSuccess_ThenReturnProductList() {
        let expectation = XCTestExpectation(description: "Wait for success use case.")
        var products: ProductsResult?

        self.sut.execute(params: SearchProductParams(query: "burger", paging: nil),
                         onSuccess: { productsList in
                             products = productsList
                             expectation.fulfill()
                         },
                         onError: { _ in
                             XCTFail("Must no fail")
                         },
                         onFinished: nil)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertNotNil(products)
        XCTAssertEqual(products?.results.count, 2)
    }

    func testBuildUseCase_WhenFail_ThenReturnInterfaceError() {
        let expectation = XCTestExpectation(description: "Wait for fail use case.")
        var errorResponse: InterfaceError?

        self.repositoryStub.error = ServiceError.customError(message: "404")
        self.sut.execute(params: SearchProductParams(query: "burger", paging: nil),
                         onSuccess: { _ in
                             XCTFail("Must fail.")
                         },
                         onError: { error in
                             errorResponse = error
                             expectation.fulfill()
                         },
                         onFinished: nil)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertNotNil(errorResponse)
        XCTAssertEqual(errorResponse, InterfaceError.custom(message: "No hay más recetas."))
    }
}

final class ProductListRespositoryStub: ProductListRespositoryType {
    var error: ServiceError?

    func searchProduct(by query: String, page: CorePaginate?) -> AnyPublisher<ProductsResult, ServiceError> {
        guard let error = self.error else {
            return Just(ProductsResult(
                results: [
                    ProductInformation(identifier: "1", title: "Title 1", imageURL: URL(string: "www.google.com")!, imageType: .jpg),
                    ProductInformation(identifier: "2", title: "Title 2", imageURL: URL(string: "www.google.com")!, imageType: .png),
                ],
                paginate: CorePaginate(offset: 0, number: 10, total: 10)))
                .setFailureType(to: ServiceError.self)
                .eraseToAnyPublisher()
        }

        return Fail(error: error).eraseToAnyPublisher()
    }
}
