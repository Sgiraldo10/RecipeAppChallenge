//
//  ApplicationConfigurator.swift
//  ProxyApplication
//
//  Created Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import UIKit

final class ApplicationConfigurator {
    static func getModule(moduleInput: ApplicationConfigurator.ModuleInput) -> UIViewController {
        let presenter = ApplicationPresenter(
            dependencies: ApplicationPresenter.Dependencies(coordinator: moduleInput.coordinator))

        let viewController = ApplicationViewController(presenter: presenter)
        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }
}

extension ApplicationConfigurator {
    struct ModuleInput {
        let coordinator: ApplicationCoordinatorType
    }
}
