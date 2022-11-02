//
//  Error+Extensio.swift
//  CoreModule
//
//  Created by Sergio Giraldo on 28/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import UIKit

public extension Error where Self == InterfaceError {
    func showError(completion: @escaping (UIAlertController) -> Void) {
        let builder = AlertControllerBuilder()

        switch self {
        case .custom(message: let meessage):
            builder
                .with(title: "Error")
                .with(message: meessage)
                .createOption(title: "Aceptar", style: .default, handleAction: nil)
            
        }

        completion(builder.build())
    }
}
