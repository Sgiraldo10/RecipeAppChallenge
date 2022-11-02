//
//  ProductInformation.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

enum ImageType: String {
    case png
    case jpg
}

struct ProductInformation: Hashable & Equatable {
    let identifier: String
    let title: String
    let imageURL: URL
    let imageType: ImageType
}
