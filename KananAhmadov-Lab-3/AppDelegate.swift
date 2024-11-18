//
//  AppDelegate.swift
//  KananAhmadov-Lab-3
//
//  Created by Ahmadov, Kanan on 10/9/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handled = handleQuickAction(shortcutItem)
        completionHandler(handled)
    }

    // function to handle quick actions and modify the app's behavior accordingly
    func handleQuickAction(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        guard let rootViewController = window?.rootViewController as? ViewController else { return false }

        switch shortcutItem.type {
        case "com.kanan.drawcircle":
            rootViewController.currentShapeType = .circle
            rootViewController.currentMode = .draw
            
        case "com.kanan.drawrectangle":
            rootViewController.currentShapeType = .rectangle
            rootViewController.currentMode = .draw
            
        case "com.kanan.drawtriangle":
            rootViewController.currentShapeType = .triangle
            rootViewController.currentMode = .draw
            
        default:
            return false
        }

        return true
    }
}
