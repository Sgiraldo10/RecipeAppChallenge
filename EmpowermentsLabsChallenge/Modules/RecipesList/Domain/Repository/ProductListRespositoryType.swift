//
//  ProductListRespositoryType.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import NetworkModule
import CoreModule

protocol ProductListRespositoryType: AnyObject {
    func searchProduct(by query: String, page: CorePaginate?) -> AnyPublisher<ProductsResult, ServiceError>
}
