//
//  CoreWrapperError.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 27/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public enum CoreWrapperError: Error {
    case requiredValueNotFound(description: String)
}
