//
//  RecipeDetailContrat.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule
import UIKit

protocol RecipeDetailViewControllerType: AnyObject, ErrorShowable, ProgressShowable {
    func setupView(from model: RecipeInformation)
}

protocol RecipeDetailPresenterType: Bindable {}

protocol RecipeDetailViewType: UIView {
    func setupView(with data: RecipeInformation)
}
