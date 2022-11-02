//
//  RESTClientType.swift
//  NetworkModule
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine

public protocol RESTClientType: AnyObject {
    var baseURL: String { get }

    func requestTo<Response: Codable>(endpoint: RESTEndpointType, model: Response.Type) -> AnyPublisher<Response, ServiceError>
}
