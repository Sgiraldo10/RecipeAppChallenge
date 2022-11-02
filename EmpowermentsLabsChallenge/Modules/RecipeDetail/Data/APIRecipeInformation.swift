//
//  APIRecipeInformation.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Foundation
import CoreModule

struct APIRecipeInformation: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var imageType: String?
    var summary: String?
    var instructions: String?
    var healthScore: Int?
    var pricePerServing: Double?
}
