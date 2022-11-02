//
//  ProductListSectionViewModel.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import Foundation

struct ProductListSectionViewModel: SectionType {
    var identifier: UUID = UUID()
    var title: String
    var data: [ProductInformation]
}
