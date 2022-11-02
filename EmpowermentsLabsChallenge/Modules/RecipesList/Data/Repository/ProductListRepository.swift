//
//  ProductListRepository.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import CoreModule
import NetworkModule

final class ProductListRespository {
    private enum Constant {
        static let relativePath = "/recipes/complexSearch"
        static let numberOfRecipes: UInt16 = 15
    }

    private let client: RESTClientType

    init(client: RESTClientType) {
        self.client = client
    }

    private func endpointForQueryParams(_ queryParams: [String: Any]) -> RESTEndpoint {
        return RESTEndpoint(method: .get, relativePath: Constant.relativePath, params: queryParams, contentType: .URLEncoded)
    }

    private func getQueryParams(for query: String, and page: CorePaginate?) throws -> [String: String] {
        guard let pagination = page else {
            return ["query": query, "offset": "0", "number": "\(Constant.numberOfRecipes)"]
        }

        guard pagination.total > pagination.offset else {
            throw ServiceError.customError(message: "404")
        }

        return ["query": query, "offset": "\(pagination.offset + Constant.numberOfRecipes)", "number": "\(pagination.number)"]
    }

    private func mapData(_ data: APIProductList) -> AnyPublisher<ProductsResult, ServiceError> {
        do {
            let domainData = try ProductListWrapper.map(data)
            return Future { $0(.success(domainData)) }.eraseToAnyPublisher()
        } catch {
            return Fail(error: ServiceError.serverError(response: error)).eraseToAnyPublisher()
        }
    }
}

extension ProductListRespository: ProductListRespositoryType {
    func searchProduct(by query: String, page: CorePaginate?) -> AnyPublisher<ProductsResult, ServiceError> {
        do {
            let params = try getQueryParams(for: query, and: page)

            return client.requestTo(endpoint: endpointForQueryParams(params), model: APIProductList.self)
                .flatMap { self.mapData($0) }
                .eraseToAnyPublisher()
        } catch {
            LocalLogger.register(model: LogModel(level: .error, data: "Query: \(query), Pagination: \(String(describing: page))"))
            return Fail(error: error as! ServiceError).eraseToAnyPublisher()
        }
    }
}
