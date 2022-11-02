//
//  RecipeDetailConfigurator.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule
import NetworkModule
import UIKit

struct RecipeDetailConfigurator {
    static func getModule(moduleInput: RecipeDetailConfigurator.ModuleInput) -> UIViewController {
        let presenter = RecipeDetailPresenter(
            dependencies: RecipeDetailPresenter.Dependencies(
                getProductByIdUseCase: GetProductByIdUseCase(productRepository: ProductDetailRepository(client: moduleInput.client)),
                coordinator: moduleInput.coordinator,
                productInformation: moduleInput.productInformation))

        let viewController = RecipeDetailViewController(presenter: presenter)
        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }
}

extension RecipeDetailConfigurator {
    struct ModuleInput {
        let coordinator: ProductListCoordinatorType
        let client: RESTClientType
        let productInformation: ProductInformation

        public init(coordinator: ProductListCoordinatorType, client: RESTClientType, productInformation: ProductInformation) {
            self.coordinator = coordinator
            self.client = client
            self.productInformation = productInformation
        }
    }
}
