//
//  SceneDelegate.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 29/10/22.
//

import CoreModule

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinatorType!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        (UIApplication.shared.delegate as? AppDelegate)?.window = window

        applicationCoordinator = ApplicationCoordinator(window: window!)
        applicationCoordinator.start()
    }
}
