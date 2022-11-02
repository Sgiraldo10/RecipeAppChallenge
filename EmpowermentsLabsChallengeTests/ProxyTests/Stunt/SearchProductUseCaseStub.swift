//
//  SearchProductUseCaseStub.swift
//  EmpowermentsLabsChallengeTests
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Combine
import CoreModule
import Foundation

@testable import EmpowermentsLabsChallenge

final class SearchProductUseCaseStub: BaseUseCaseTestable<ProductsResult, SearchProductParams> {
    var error: InterfaceError?
    var isEmptyData = false

    override func buildUseCase(params: SearchProductParams) -> AnyPublisher<ProductsResult, InterfaceError> {
        guard let error = self.error else {
            if isEmptyData {
                return Just(ProductsResult(results: [], paginate: CorePaginate(offset: 0, number: 10, total: 10)))
                    .setFailureType(to: InterfaceError.self)
                    .eraseToAnyPublisher()
            }

            return Just(ProductsResult(
                results: [
                    ProductInformation(identifier: "1", title: "Title 1", imageURL: URL(string: "www.google.com")!, imageType: .jpg),
                    ProductInformation(identifier: "2", title: "Title 2", imageURL: URL(string: "www.google.com")!, imageType: .png),
                ],
                paginate: CorePaginate(offset: 0, number: 10, total: 10)
            ))
                .setFailureType(to: InterfaceError.self)
                .eraseToAnyPublisher()
        }

        return Fail(error: error).eraseToAnyPublisher()
    }
}
