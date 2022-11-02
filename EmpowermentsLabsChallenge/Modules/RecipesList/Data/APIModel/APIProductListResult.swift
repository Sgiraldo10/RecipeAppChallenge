//
//  APIProductListResult.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule

struct APIProductListResult: Codable {
    let identifier: Int?
    let title: String?
    let imageURL: String?
    let imageType: String?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imageURL = "image"
        case title, imageType
    }
}
