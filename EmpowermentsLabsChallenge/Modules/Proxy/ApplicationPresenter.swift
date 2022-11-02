//
//  ApplicationPresenter.swift
//  ProxyApplication
//
//  Created Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule

final class ApplicationPresenter: BasePresenter<ApplicationViewControllerType> {
    struct Dependencies {
        var coordinator: ApplicationCoordinatorType
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
}

extension ApplicationPresenter: ApplicationPresenterType {
    func animationCompleted() {
        self.dependencies.coordinator.runProductListModule()
    }
}
