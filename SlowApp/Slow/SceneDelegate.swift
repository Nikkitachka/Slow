//
//  SceneDelegate.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 02.11.2021.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
//        try? Auth.auth().signOut()
        if Auth.auth().currentUser != nil {
            window?.rootViewController = MainViewController()
            window?.makeKeyAndVisible()
        } else {
            let authControllers = UINavigationController(rootViewController: SignUpController())
            window?.rootViewController = authControllers
            window?.makeKeyAndVisible()
        }
        
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

