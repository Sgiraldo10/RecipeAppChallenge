//
//  CellReusable.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public protocol CellReusable {
    static var reuseIdentifier: String { get }
}

public extension CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
