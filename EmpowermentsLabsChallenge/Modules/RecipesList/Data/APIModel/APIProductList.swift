//
//  APIProductList.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation
import CoreModule

struct APIProductList: Codable {
    let results: [APIProductListResult]
    let offset: UInt16
    let number: UInt16
    let totalResults: UInt16
}
