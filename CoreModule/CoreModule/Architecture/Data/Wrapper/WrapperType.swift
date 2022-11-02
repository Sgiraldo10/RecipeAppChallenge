//
//  BaseWrapper.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public protocol CoreWrapperType {
    associatedtype APIData: Codable
    associatedtype CoreData

    static func map(_ apiData: APIData) throws -> CoreData
}
