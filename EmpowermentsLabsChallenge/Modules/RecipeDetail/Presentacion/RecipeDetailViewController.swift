//
//  RecipeDetailViewController.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule
import UIKit

final class RecipeDetailViewController: BaseViewController<RecipeDetailPresenterType, RecipeDetailViewType> {
    override func loadView() {
        view = RecipeDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Information"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Theme.Color.primary]
        navigationController?.navigationBar.tintColor = Theme.Color.primary
    }
}

extension RecipeDetailViewController: RecipeDetailViewControllerType {
    func setupView(from model: RecipeInformation) {
        customView.setupView(with: model)
    }
}
