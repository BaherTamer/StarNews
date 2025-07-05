//
//  ArticlesRouter.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import ArticleDetails
import Search
import SNCore
import UIKit.UIViewController

@MainActor
protocol ArticlesRouter {
    var screenVC: UIViewController? { get set }
    
    func navigateToSearch()
    func navigateToArticleDetails(with id: Int)
}

final class DefaultArticlesRouter: ArticlesRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension DefaultArticlesRouter {
    func navigateToSearch() {
        let factory: SuggestionsFactory = DefaultSuggestionsFactory()
        let viewController = factory.create()
        screenVC?.pushVC(viewController)
    }
    
    func navigateToArticleDetails(with id: Int) {
        let factory: ArticleDetailsFactory = DefaultArticleDetailsFactory()
        let viewController = factory.create(with: id)
        screenVC?.pushVC(viewController)
    }
}
