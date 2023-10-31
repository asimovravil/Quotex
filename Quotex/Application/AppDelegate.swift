//
//  AppDelegate.swift
//  Quotex
//
//  Created by Ravil on 18.10.2023.
//

import UIKit
import Firebase
import OneSignalFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().tintColor = UIColor.white
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
         OneSignal.initialize("f9debf07-6940-4230-b078-4df7dc35569f", withLaunchOptions: launchOptions)
         OneSignal.Notifications.requestPermission({ accepted in
           print("User accepted notifications: \(accepted)")
         }, fallbackToSettings: true)
               UserDefaults.standard.removeObject(forKey: "url")
        UINavigationBar.appearance().tintColor = UIColor.white
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

