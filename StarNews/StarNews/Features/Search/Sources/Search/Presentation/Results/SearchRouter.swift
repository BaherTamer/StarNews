//
//  SearchRouter.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import ArticleDetails
import SNCore
import UIKit.UIViewController

@MainActor
protocol SearchRouter {
    var screenVC: UIViewController? { get set }
    
    func navigateToArticleDetails(with id: Int)
}

final class DefaultSearchRouter: SearchRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension DefaultSearchRouter {
    func navigateToArticleDetails(with id: Int) {
        let factory: ArticleDetailsFactory = DefaultArticleDetailsFactory()
        let viewController = factory.create(with: id)
        screenVC?.pushVC(viewController)
    }
}
