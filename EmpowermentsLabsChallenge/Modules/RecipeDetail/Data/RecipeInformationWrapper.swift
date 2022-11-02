//
//  RecipeInformationWrapper.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule
import Foundation

struct RecipeInformationWrapper: CoreWrapperType {
    static func map(_ apiData: APIRecipeInformation) throws -> RecipeInformation {
        RecipeInformation(
            identifier: "\(apiData.id ?? 12345)",
            title: apiData.title ?? "No title information",
            imageURL: URL(string: apiData.image ?? ""),
            imageType: ImageType(rawValue: apiData.imageType ?? "") ?? .png,
            summary: apiData.summary ?? "No summary added.",
            instructions: apiData.instructions ?? "No instructions added.",
            healthScore: String(apiData.healthScore ?? 0),
            pricePerServing: String(apiData.pricePerServing ?? 0.0))
    }
}
