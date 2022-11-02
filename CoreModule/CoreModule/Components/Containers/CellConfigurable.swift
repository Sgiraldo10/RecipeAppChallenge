//
//  CellConfigurable.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import UIKit

public protocol CellConfigurable: AnyObject, CellReusable {
    associatedtype DataType: Hashable

    func configure(with data: DataType)
}
