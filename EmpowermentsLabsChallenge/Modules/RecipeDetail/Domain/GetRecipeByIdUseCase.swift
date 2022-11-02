//
//  GetRecipeByIdUseCase.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Combine
import CoreModule
import NetworkModule

final class GetProductByIdUseCase: BaseUseCase<RecipeInformation, String> {
    private var productRepository: ProductDetailRepositoryType

    init(productRepository: ProductDetailRepositoryType) {
        self.productRepository = productRepository
    }

    override func buildUseCase(params: String) -> AnyPublisher<RecipeInformation, InterfaceError> {
        productRepository.product(by: params)
            .mapError { self.userFriendlyError($0) }
            .eraseToAnyPublisher()
    }

    private func userFriendlyError(_ error: Error) -> InterfaceError {
        LocalLogger.register(model: LogModel(level: .error, data: error.localizedDescription, message: "Error while request product by id."))

        return InterfaceError.custom(
            message: "Se hizo un prueba COVID al dispositivo y resulto positiva, por favor ponerse en contacto con servicio sanitario.")
    }
}
