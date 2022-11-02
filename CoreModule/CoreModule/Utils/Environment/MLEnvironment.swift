//
//  MLEnvironment.swift
//  
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public struct MLEnvironment {
    public static let shared = MLEnvironment()

    public var selected: EnvironmentType {
        getEnvironment()
    }

    private init() {}

    private func getEnvironment() -> EnvironmentType {
        #if DEBUG
            return .debug
        #else
            return .release
        #endif
    }
}
