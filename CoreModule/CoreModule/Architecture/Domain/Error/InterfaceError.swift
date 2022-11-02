//
//  InterfaceError.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public enum InterfaceError: Error, Equatable {
    case custom(message: String)
}
