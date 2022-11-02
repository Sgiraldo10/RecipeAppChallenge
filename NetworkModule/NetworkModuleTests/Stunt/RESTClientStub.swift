//
//  RESTClientStub.swift
//  NetworkModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import Foundation

@testable import NetworkModule

final class RESTClientStub: RESTClientType {
    var baseURL: String
    var response: Codable!
    var responseError: ServiceError?
    var finishRequest: (() -> Void)!

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func requestTo<Response: Codable>(endpoint: RESTEndpointType, model: Response.Type) -> AnyPublisher<Response, ServiceError> {
        guard responseError == nil else {
            return Fail(error: responseError!).eraseToAnyPublisher()
        }

        let publisher = CurrentValueSubject<Response, ServiceError>(response! as! Response)

        /// This is required due to `Subject` will start emitting values only when it gets subscribed so we need to subscribe first to recive values.
        finishRequest = { publisher.send(completion: .finished) }

        return publisher.print().eraseToAnyPublisher()
    }
}
