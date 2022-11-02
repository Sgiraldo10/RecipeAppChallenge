//
//  RESTEndpointType.swift
//  NetworkModule
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

public protocol RESTEndpointType {
    var method: RESTMethod { get }
    var relativePath: String { get }
    var params: [String: Any]? { get }
    var contentType: RESTContentType { get }
}
