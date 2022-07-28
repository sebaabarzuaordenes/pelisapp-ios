//
//  SceneDelegate.swift
//  PelisApp
//
//  Created by sebastian abarzua on 14-07-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let vistaScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = HomeRouter().viewController
        let navController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.windowScene = vistaScene
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

