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
        let viewController = Resolver.resolve(\.articleDetailsScreen, id)
        pushVC(viewController)
    }
    
    func navigateToSearchResults(with query: String) {
        let viewController = Resolver.resolve(\.searchScreen, query)
        pushVC(viewController)
    }
}
