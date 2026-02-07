//
//  SearchRouter.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import ArticleDetails
import SNCore
import UIKit.UIViewController

protocol SearchRouter: Router {
    func pushArticleDetails(with id: Int)
}

final class DefaultSearchRouter: SearchRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension DefaultSearchRouter {
    func pushArticleDetails(with id: Int) {
        let viewController = Resolver.resolve(\.articleDetailsScreen, id)
        pushVC(viewController)
    }
}
