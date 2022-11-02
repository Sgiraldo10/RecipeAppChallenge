//
//  ProductListPresenterTest.swift
//  EmpowermentsLabsChallengeTests
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Combine
import CoreModule
import XCTest

@testable import EmpowermentsLabsChallenge

final class ProductListPresenterTest: XCTestCase {
    private var sut: ProductListPresenter!
    private var viewSpy: ProductListViewControllerSpy!
    private var coordinatorSpy: ProductListCoordinatorSpy!
    private var useCaseStub: SearchProductUseCaseStub!

    override func setUp() {
        super.setUp()

        self.coordinatorSpy = ProductListCoordinatorSpy()
        self.useCaseStub = SearchProductUseCaseStub()
        self.viewSpy = ProductListViewControllerSpy()

        self.sut = ProductListPresenter(dependencies: ProductListPresenter.Dependencies(
            coordinator: self.coordinatorSpy,
            searchProductUseCase: self.useCaseStub))

        self.sut.bind(view: self.viewSpy)
    }

    override func tearDown() {
        self.sut = nil
        self.viewSpy = nil
        self.coordinatorSpy = nil
        self.useCaseStub = nil

        super.tearDown()
    }

    func testSearchBarSearchButtonClicked_WhenExistProducts_ThenSearchProductAndShow() {
        self.sut.searchBarSearchButtonClicked(with: "burger")

        XCTAssertTrue(self.viewSpy.showProgressCalled)
        XCTAssertTrue(self.viewSpy.showProductCalled)
        XCTAssertTrue(self.viewSpy.setDescriptionTitleCalled)
        XCTAssertTrue(self.viewSpy.hideProgressCalled)
    }

    func testSearchBarSearchButtonClicked_WhenProductsAreEmpty_ThenSearchProductAndShowEmptyState() {
        self.useCaseStub.isEmptyData = true
        self.sut.searchBarSearchButtonClicked(with: "burger")

        XCTAssertTrue(self.viewSpy.showEmptyStateCalled)
    }

    func testSearchBarSearchButtonClicked_WhenError_ThenPresentError() {
        self.useCaseStub.error = InterfaceError.custom(message: "404")
        self.sut.searchBarSearchButtonClicked(with: "burger")

        XCTAssertTrue(self.viewSpy.presentErrorCalled)
        XCTAssertTrue(self.viewSpy.hideProgressCalled)
    }

    func testSelectedItem_WhenCalled_ThenRunProductDetailModule() {
        self.sut.searchBarSearchButtonClicked(with: "burger")
        self.sut.selectedItem(at: IndexPath(item: 1, section: 0))

        XCTAssertTrue(self.coordinatorSpy.runProductDetailModuleCalled)
    }
}
