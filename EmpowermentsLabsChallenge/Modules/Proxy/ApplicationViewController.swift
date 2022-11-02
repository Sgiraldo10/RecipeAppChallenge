//
//  ApplicationViewController.swift
//  ProxyApplication
//
//  Created Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import UIKit

final class ApplicationViewController: BaseViewController<ApplicationPresenterType, ApplicationViewType> {
    override func loadView() {
        view = ApplicationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseIn,
                       animations: {
                           self.customView.logoImageView.alpha = 1.0
                       },
                       completion: { _ in
                           self.presenter.animationCompleted()
                       })

        self.view.backgroundColor = .white
    }
}

extension ApplicationViewController: ApplicationViewControllerType {}
