//
//  RESTClient.swift
//  NetworkModule
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import Foundation
import CoreModule

public final class RESTClient {
    private struct Constant {
        static let httpHeader = "Content-Type"
        static let apiKeyValue = "95620357822e41c39f140a49991eb2e3"
        static let apiKey = "apiKey"
    }

    public let baseURL: String

    public init(baseURL: String) {
        self.baseURL = baseURL
    }

    private func getURLRequest(from endpoint: RESTEndpointType) throws -> URLRequest {
        /// We could make force cast due to  `getURLComponents` is returning a valid `URLComponent` with a non nil `URL` or throwing an error.
        var request = URLRequest(url: try getURLComponents(from: endpoint).url!)

        request.httpMethod = endpoint.method.rawValue
        request.setValue(endpoint.contentType.rawValue, forHTTPHeaderField: Constant.httpHeader)
        request.httpBody = try getHttpBody(from: endpoint)

        LocalLogger.register(model: LogModel(level: .debug, data: "URLRequest: \(request)"))
        return request
    }

    private func getURLComponents(from endpoint: RESTEndpointType) throws -> URLComponents {
        guard var urlComponents = URLComponents(string: baseURL + endpoint.relativePath) else {
            let errorMessage = "Invalid baseURL: \(baseURL)"
            LocalLogger.register(model: LogModel(level: .error, data: errorMessage))
            throw ServiceError.invalidPath(message: errorMessage)
        }

        guard endpoint.contentType == .URLEncoded else {
            LocalLogger.register(model: LogModel(level: .debug, data: "URLComponents: \(urlComponents)"))
            return urlComponents
        }

        guard let params = endpoint.params as? [String: String] else {
            let errorMessage = "Invalid format params for URL encoded content type. Params: \(endpoint.params ?? [:])"
            LocalLogger.register(model: LogModel(level: .error, data: errorMessage))
            throw ServiceError.invalidParams(message: errorMessage)
        }

        urlComponents.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
        urlComponents.queryItems?.append(URLQueryItem(name: Constant.apiKey, value: Constant.apiKeyValue))
        LocalLogger.register(model: LogModel(level: .debug, data: "URLComponents: \(urlComponents)"))

        return urlComponents
    }

    private func getHttpBody(from endpoint: RESTEndpointType) throws -> Data? {
        guard endpoint.contentType == .json, endpoint.method == .post, let params = endpoint.params else {
            return nil
        }

        return try JSONSerialization.data(withJSONObject: params, options: [])
    }

    private func handleResponse(_ response: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let resp = response.response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw ServiceError.serverError(response: response.response)
        }

        LocalLogger.register(model: LogModel(level: .info, data: "Data Response: \(String(data: response.data, encoding: .utf8) ?? "")"))
        return response.data
    }
}

extension RESTClient: RESTClientType {
    public func requestTo<Response: Codable>(endpoint: RESTEndpointType, model: Response.Type) -> AnyPublisher<Response, ServiceError> {
        do {
            return URLSession.shared.dataTaskPublisher(for: try getURLRequest(from: endpoint))
                .retry(2)
                .tryMap { try self.handleResponse($0) }
                .decode(type: Response.self, decoder: JSONDecoder())
                .mapError {
                    LocalLogger.register(model: LogModel(level: .error, data: $0))
                    return ServiceError.decodeError(error: $0)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error as! ServiceError).eraseToAnyPublisher()
        }
    }
}
