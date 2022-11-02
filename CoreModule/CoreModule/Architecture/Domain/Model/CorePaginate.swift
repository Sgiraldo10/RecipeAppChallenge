//
//  CorePaginate.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

public struct CorePaginate {
    public let offset: UInt16
    public let number: UInt16
    public let total: UInt16

    public init(offset: UInt16, number: UInt16, total: UInt16) {
        self.offset = offset
        self.number = number
        self.total = total
    }
}
