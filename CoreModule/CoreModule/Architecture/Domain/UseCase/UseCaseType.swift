//
//  UseCaseType.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import Foundation

public protocol UseCaseType: AnyObject {
    associatedtype Response
    associatedtype Params

    func execute(params: Params, onSuccess: @escaping (Response) -> Void, onError: ((InterfaceError) -> Void)?, onFinished: (() -> Void)?)
}

open class BaseUseCase<R, P>: UseCaseType {
    public typealias Response = R
    public typealias Params = P

    private var cancelable = Set<AnyCancellable>()

    public init() {}

    open func execute(params: Params, onSuccess: @escaping (Response) -> Void, onError: ((InterfaceError) -> Void)?, onFinished: (() -> Void)?) {
        buildUseCase(params: params)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        onError?(error)
                    case .finished:
                        onFinished?()
                    }
                },
                receiveValue: { value in
                    onSuccess(value)
                }
            )
            .store(in: &cancelable)
    }

    open func buildUseCase(params: Params) -> AnyPublisher<Response, InterfaceError> {
        preconditionFailure("This must be overriden.")
    }
}
