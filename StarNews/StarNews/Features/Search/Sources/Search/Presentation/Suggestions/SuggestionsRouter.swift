//
//  SuggestionsRouter.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import ArticleDetails
import SNCore
import UIKit.UIViewController

protocol SuggestionsRouter: Router {
    func navigateToArticleDetails(with id: Int)
    func navigateToSearchResults(with query: String)
}

final class DefaultSuggestionsRouter: SuggestionsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension DefaultSuggestionsRouter {
    func navigateToArticleDetails(with id: Int) {
        let factory: ArticleDetailsFactory = DefaultArticleDetailsFactory()
        let viewController = factory.create(with: id)
        pushVC(viewController)
    }
    
    func navigateToSearchResults(with query: String) {
        let factory: SearchFactory = DefaultSearchFactory()
        let viewController = factory.create(with: query)
        pushVC(viewController)
    }
}
