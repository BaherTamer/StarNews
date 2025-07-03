//
//  SuggestionsRouter.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import ArticleDetails
import SNCore
import UIKit.UIViewController

@MainActor
protocol SuggestionsRouter {
    var screenVC: UIViewController? { get set }
    
    func navigateToArticleDetails(with id: Int)
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
        screenVC?.pushVC(viewController)
    }
}
