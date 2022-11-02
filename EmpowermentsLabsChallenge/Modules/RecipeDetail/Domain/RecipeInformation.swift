//
//  RecipeInformation.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import Foundation
import UIKit

struct RecipeInformation {
    var identifier: String
    var title: String
    var imageURL: URL?
    var imageType: ImageType
    var summary: String
    var instructions: String
    var healthScore: String
    var pricePerServing: String
}
