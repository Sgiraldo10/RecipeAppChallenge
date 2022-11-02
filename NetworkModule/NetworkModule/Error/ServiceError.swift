//
//  ServiceError.swift
//  NetworkModule
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
    case invalidPath(message: String)
    case invalidParams(message: String)
    case serverError(response: Any)
    case decodeError(error: Error)
    case customError(message: String)
}
