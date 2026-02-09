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
    func pushArticleDetails(with id: Int)
    func pushSearchResults(with query: String)
}

final class SuggestionsRouterImpl: SuggestionsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension SuggestionsRouterImpl {
    func pushArticleDetails(with id: Int) {
        let viewController = Resolver.resolve(\.articleDetailsScreen, id)
        pushVC(viewController)
    }
    
    func pushSearchResults(with query: String) {
        let viewController = Resolver.resolve(\.searchScreen, query)
        pushVC(viewController)
    }
}
