//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 20.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = WeatherViewController()
        let navigationCon = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationCon
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

