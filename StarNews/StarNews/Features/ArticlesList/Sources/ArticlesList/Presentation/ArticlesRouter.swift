//
//  ArticlesRouter.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import ArticleDetails
import SNCore
import UIKit.UIViewController

protocol ArticlesRouter {
    var screenVC: UIViewController? { get set }
    
    @MainActor
    func navigateToArticleDetails(with id: Int)
}

final class DefaultArticlesRouter: ArticlesRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension DefaultArticlesRouter {
    @MainActor
    func navigateToArticleDetails(with id: Int) {
        let factory: ArticleDetailsFactory = DefaultArticleDetailsFactory()
        let viewController = factory.create(with: id)
        screenVC?.pushVC(viewController)
    }
}
