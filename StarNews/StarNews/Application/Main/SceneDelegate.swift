//
//  SceneDelegate.swift
//  StarNews
//
//  Created by Baher Tamer on 19/06/2025.
//

import ArticlesList
import UIKit.UIScene

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Variables
    var window: UIWindow?
}

// MARK: - UIWindowSceneDelegate
extension SceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let factory: ArticlesFactory = DefaultArticlesFactory()
        let viewController = factory.create()
        window.overrideUserInterfaceStyle = .dark
        window.rootViewController = UINavigationController(
            rootViewController: viewController
        )
        self.window = window
        window.makeKeyAndVisible()
    }
}
