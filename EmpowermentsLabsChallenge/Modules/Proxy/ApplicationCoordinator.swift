//
//  ApplicationCoordinatorType.swift
//  ProxyApplication
//
//  Created Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import NetworkModule
import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let restClient: RESTClientType

    init(window: UIWindow, restClient: RESTClientType = RESTClient(baseURL: MLEnvironment.shared.selected.baseURL)) {
        self.window = window
        self.restClient = restClient
        super.init()
    }

    override func start() {
        let module = ApplicationConfigurator.getModule(
            moduleInput: ApplicationConfigurator.ModuleInput(coordinator: self))

        navigationController.setViewControllers([module], animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorType {
    func runProductListModule() {
        let module = ProductListConfigurator.getModule(
            moduleInput: ProductListConfigurator.ModuleInput(coordinator: self, client: restClient))

        navigationController.setViewControllers([module], animated: false)
    }

    func runProductDetailModule(for product: Any) {
        guard let productInformation = product as? ProductInformation else {
            fatalError("Invalid data.")
        }

        let module = RecipeDetailConfigurator.getModule(
            moduleInput: RecipeDetailConfigurator.ModuleInput(
                coordinator: self,
                client: restClient,
                productInformation: productInformation))

        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(module, animated: true)
    }
}
