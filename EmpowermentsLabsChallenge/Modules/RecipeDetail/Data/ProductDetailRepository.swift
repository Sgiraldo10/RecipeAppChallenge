//
//  ProductDetailRepository.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Combine
import CoreModule
import NetworkModule

final class ProductDetailRepository {
    private let client: RESTClientType

    init(client: RESTClientType) {
        self.client = client
    }

    private func endpointForProductId(_ id: String) -> RESTEndpoint {
        let relativePath = "/recipes/\(id)/information"
        return RESTEndpoint(method: .get, relativePath: relativePath, params: [:], contentType: .URLEncoded)
    }

    private func mapData(_ data: APIRecipeInformation) -> AnyPublisher<RecipeInformation, ServiceError> {
        do {
            let domainData = try RecipeInformationWrapper.map(data)
            return Future { $0(.success(domainData)) }.eraseToAnyPublisher()
        } catch {
            return Fail(error: ServiceError.serverError(response: error)).eraseToAnyPublisher()
        }
    }
}

extension ProductDetailRepository: ProductDetailRepositoryType {
    func product(by id: String) -> AnyPublisher<RecipeInformation, ServiceError> {
        client.requestTo(endpoint: endpointForProductId(id), model: APIRecipeInformation.self)
            .flatMap { self.mapData($0) }
            .eraseToAnyPublisher()
    }
}
