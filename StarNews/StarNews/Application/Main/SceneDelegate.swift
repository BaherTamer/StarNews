//
//  SceneDelegate.swift
//  StarNews
//
//  Created by Baher Tamer on 19/06/2025.
//

import ArticlesList
import SNCore
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
        // TODO: Add app coordinator
        let viewController = Resolver.resolve(\.articlesScreen)
        window.overrideUserInterfaceStyle = .dark
        window.rootViewController = UINavigationController(
            rootViewController: viewController
        )
        self.window = window
        window.makeKeyAndVisible()
    }
}
