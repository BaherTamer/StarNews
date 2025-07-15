//
//  MockArticlesRouter.swift
//  ArticlesList
//
//  Created by Baher Tamer on 07/07/2025.
//

import UIKit.UIViewController
@testable import ArticlesList

protocol TestableArticlesRouter: ArticlesRouter {
    var didNavigateToSearch: Bool { get }
    var navigatedToArticleID: Int? { get }
}

final class MockArticlesRouter: TestableArticlesRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
    var didNavigateToSearch = false
    var navigatedToArticleID: Int?
    
    // MARK: - Navigation Functions
    func navigateToSearch() {
        didNavigateToSearch = true
    }
    
    func navigateToArticleDetails(with id: Int) {
        navigatedToArticleID = id
    }
}
