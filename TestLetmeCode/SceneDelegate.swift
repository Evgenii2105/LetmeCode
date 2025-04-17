//
//  SceneDelegate.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let loginVC = LoginViewController()

        let userStorage = UserStorage()
        let loginPresenter = LoginPresenterImpl(userStrorage: userStorage)
        
        loginVC.presenter = loginPresenter
        loginPresenter.view = loginVC
        
        let navController = UINavigationController(rootViewController: loginVC)
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
