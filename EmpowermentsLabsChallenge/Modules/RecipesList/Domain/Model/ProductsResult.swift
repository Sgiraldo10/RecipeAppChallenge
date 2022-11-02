//
//  ProductsResult.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule

struct ProductsResult {
    let results: [ProductInformation]
    let paginate: CorePaginate
}
