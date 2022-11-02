//
//  ProductListViewControllerSpy.swift
//  EmpowermentsLabsChallengeTests
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule
import UIKit

@testable import EmpowermentsLabsChallenge

final class ProductListViewControllerSpy: UIViewController, ProductListViewControllerType, ViewControllerBindable {
    var showProductCalled = false
    var setDescriptionTitleCalled = false
    var showEmptyStateCalled = false
    var showProgressCalled = false
    var hideProgressCalled = false
    var presentErrorCalled = false

    func showProduct(_ productSection: ProductListSectionViewModel) {
        self.showProductCalled = true
    }

    func showEmptyState(_ productSection: ProductListSectionViewModel, message: String) {
        self.showEmptyStateCalled = true
    }

    func setDescriptionTitle(_ title: String) {
        self.setDescriptionTitleCalled = true
    }

    func didSelectItem(at indexPath: IndexPath) {}

    func loadMore() {}

    func presentError(_ error: InterfaceError) {
        self.presentErrorCalled = true
    }

    func showProgress() {
        self.showProgressCalled = true
    }

    func hideProgress() {
        self.hideProgressCalled = true
    }
}
