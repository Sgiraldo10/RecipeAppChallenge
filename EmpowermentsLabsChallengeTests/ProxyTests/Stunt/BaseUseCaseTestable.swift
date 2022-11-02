//
//  BaseUseCaseTestable.swift
//  EmpowermentsLabsChallengeTests
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Combine
import CoreModule
import Foundation

@testable import EmpowermentsLabsChallenge

class BaseUseCaseTestable<R, P>: BaseUseCase<R, P> {
    private var cancelableTest = Set<AnyCancellable>()

    override func execute(params: Params, onSuccess: @escaping (Response) -> Void, onError: ((InterfaceError) -> Void)?, onFinished: (() -> Void)?) {
        buildUseCase(params: params)
            .receive(on: ImmediateScheduler.shared)
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
            .store(in: &cancelableTest)
    }
}
