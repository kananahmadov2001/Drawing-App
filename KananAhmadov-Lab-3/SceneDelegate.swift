//
//  SceneDelegate.swift
//  KananAhmadov-Lab-3
//
//  Created by Ahmadov, Kanan on 10/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let rootViewController = storyboard.instantiateInitialViewController() as! ViewController

        // setting up the window with the scene
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()

        // handling quick actions if the app was launched with one
        if let shortcutItem = connectionOptions.shortcutItem {
            _ = handleQuickAction(shortcutItem)
        }
    }

    // handling quick actions
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

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

