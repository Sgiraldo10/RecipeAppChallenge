//
//  ContainerConfigurable.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public protocol ContainerConfigurable {
    associatedtype U: CellConfigurable
    associatedtype T: SectionType

    var sections: [T] { get }
}
