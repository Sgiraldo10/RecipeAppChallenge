//
//  ProductDetailRepositoryType.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import NetworkModule
import Combine

protocol ProductDetailRepositoryType: AnyObject {
    func product(by id: String) -> AnyPublisher<RecipeInformation, ServiceError>
}
