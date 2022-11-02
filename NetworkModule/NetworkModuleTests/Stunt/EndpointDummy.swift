//
//  EndpointDummy.swift
//  NetworkModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Foundation

@testable import NetworkModule

struct EndpointDummy: RESTEndpointType {
    var method: RESTMethod
    var relativePath: String
    var params: [String: Any]?
    var contentType: RESTContentType

    init() {
        method = .get
        relativePath = ""
        contentType = .json
    }
}
