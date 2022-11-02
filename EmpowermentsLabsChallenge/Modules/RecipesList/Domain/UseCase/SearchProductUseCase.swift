//
//  SearchProductUseCase.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import CoreModule
import NetworkModule

struct SearchProductParams {
    let query: String
    let paging: CorePaginate?
}

final class SearchProductUseCase: BaseUseCase<ProductsResult, SearchProductParams> {
    private var productListRepository: ProductListRespositoryType

    init(productListRepository: ProductListRespositoryType) {
        self.productListRepository = productListRepository
    }

    override func buildUseCase(params: SearchProductParams) -> AnyPublisher<ProductsResult, InterfaceError> {
        productListRepository.searchProduct(by: params.query, page: params.paging)
            .mapError { self.userFriendlyError($0) }
            .eraseToAnyPublisher()
    }

    private func userFriendlyError(_ error: Error) -> InterfaceError {
        guard let serviceError = error as? ServiceError else {
            LocalLogger.register(model: LogModel(level: .error, data: error.localizedDescription, message: "Error: \(error)"))
            return InterfaceError.custom(message: "Generic error: \(error.localizedDescription)")
        }

        var customMessage = "Ha ocurrido un error, por favor intente más tarde."

        switch serviceError {
        case .customError(let message):
            if message == "404" {
                customMessage = "No hay más recetas."
            }
        default: break
        }

        return InterfaceError.custom(message: customMessage)
    }
}
