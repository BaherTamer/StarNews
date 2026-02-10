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
    var presentShareSheetCallCount: Int { get }
}

final class MockArticlesRouter: TestableArticlesRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
    var didNavigateToSearch = false
    var navigatedToArticleID: Int?
    private(set) var presentShareSheetCallCount = 0
    
    // MARK: - Navigation Functions
    func pushSearch() {
        didNavigateToSearch = true
    }
    
    func pushArticleDetails(with id: Int) {
        navigatedToArticleID = id
    }
    
    func presentShareSheet(url: URL) {
        presentShareSheetCallCount += 1
    }
}
