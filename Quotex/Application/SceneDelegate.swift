//
//  SceneDelegate.swift
//  Quotex
//
//  Created by Ravil on 18.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var navigation: UINavigationController!
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .dark
      
        window.rootViewController = SplashViewController()
        self.window = window
        window.makeKeyAndVisible()
    
    }
}
