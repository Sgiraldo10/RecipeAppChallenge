//
//  ProductListConfigurator.swift
//  ProductList
//
//  Created Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import NetworkModule
import UIKit

public final class ProductListConfigurator {
    public static func getModule(moduleInput: ProductListConfigurator.ModuleInput) -> UIViewController {
        let presenter = ProductListPresenter(
            dependencies: ProductListPresenter.Dependencies(
                coordinator: moduleInput.coordinator,
                searchProductUseCase: SearchProductUseCase(productListRepository: ProductListRespository(client: moduleInput.client))))

        let viewController = ProductListViewController(presenter: presenter)
        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }
}

extension ProductListConfigurator {
    public struct ModuleInput {
        let coordinator: ProductListCoordinatorType
        let client: RESTClientType

        public init(coordinator: ProductListCoordinatorType, client: RESTClientType) {
            self.coordinator = coordinator
            self.client = client
        }
    }
}
