//
//  SectionType.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public protocol SectionType: Hashable {
    associatedtype DataType: Equatable & Hashable
    
    var identifier: UUID { get }
    var title: String { get }
    var data: [DataType] { get }
}
