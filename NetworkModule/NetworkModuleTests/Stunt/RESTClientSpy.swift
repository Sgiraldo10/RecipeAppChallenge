//
//  RESTClientSpy.swift
//  NetworkModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import Foundation

@testable import NetworkModule

final class RESTClientSpy: RESTClientType {
    var baseURL: String = "baseURL"
    var requestToCallBack: ((RESTEndpointType, Codable.Type) -> Void)?

    func requestTo<Response>(endpoint: RESTEndpointType, model: Response.Type) -> AnyPublisher<Response, ServiceError> {
        requestToCallBack!(endpoint, model as! Codable.Type)
        return Fail<Response, ServiceError>(error: ServiceError.serverError(response: "Error")).eraseToAnyPublisher()
    }
}
