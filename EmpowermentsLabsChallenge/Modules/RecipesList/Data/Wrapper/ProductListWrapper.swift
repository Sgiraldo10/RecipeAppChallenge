//
//  ProductListWrapper.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import Foundation

struct ProductListWrapper: CoreWrapperType {
    static func map(_ apiData: APIProductList) throws -> ProductsResult {
        let results = apiData.results.compactMap { product in
            removeInvalidData(from: product)
        }

        return ProductsResult(results: results, paginate: CorePaginate(offset: apiData.offset,
                                                                    number: apiData.number,
                                                                    total: apiData.totalResults))
    }

    private static func removeInvalidData(from data: APIProductListResult) -> ProductInformation? {
        guard let id = data.identifier,
              let title = data.title,
              let imageString = data.imageURL, let imageURL = URL(string: imageString),
              let imageTypeString = data.imageType, let imageType = ImageType(rawValue: imageTypeString) else {
            LocalLogger.register(model: LogModel(level: .error, data: data, message: "Data corrupted, please check."))
            return nil
        }

        return ProductInformation(
            identifier: String(id),
            title: title,
            imageURL: imageURL,
            imageType: imageType)
    }
}
