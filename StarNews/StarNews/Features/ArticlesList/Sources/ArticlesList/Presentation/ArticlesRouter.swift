//
//  ArticlesRouter.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import ArticleDetails
import Search
import SNCore
import UIKit

protocol ArticlesRouter: Router {
    func pushSearch()
    func pushArticleDetails(with id: Int)
    func presentShareSheet(url: URL)
}

final class ArticlesRouterImpl: ArticlesRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension ArticlesRouterImpl {
    func pushSearch() {
        let viewController = Resolver.resolve(\.suggestionsScreen)
        pushVC(viewController)
    }
    
    func pushArticleDetails(with id: Int) {
        let viewController = Resolver.resolve(\.articleDetailsScreen, id)
        pushVC(viewController)
    }
    
    func presentShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        presentVC(activityViewController)
    }
}
