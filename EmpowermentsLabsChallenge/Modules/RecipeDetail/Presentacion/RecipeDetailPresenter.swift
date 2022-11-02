//
//  RecipeDetailPresenter.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule
import Foundation

final class RecipeDetailPresenter: BasePresenter<RecipeDetailViewControllerType> {
    struct Dependencies {
        var getProductByIdUseCase: BaseUseCase<RecipeInformation, String>
        var coordinator: ProductListCoordinatorType
        var productInformation: ProductInformation
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }

    override func viewDidLoad() {
        loadProduct()
    }

    private func loadProduct() {
        view.showProgress()
        dependencies.getProductByIdUseCase.execute(
            params: dependencies.productInformation.identifier,
            onSuccess: { product in
                self.showProduct(product)
            },
            onError: { error in
                self.view.presentError(error)
            },
            onFinished: {
                self.view.hideProgress()
            })
    }

    private func showProduct(_ product: RecipeInformation) {
        view.setupView(from: product)
    }
}

extension RecipeDetailPresenter: RecipeDetailPresenterType {}

