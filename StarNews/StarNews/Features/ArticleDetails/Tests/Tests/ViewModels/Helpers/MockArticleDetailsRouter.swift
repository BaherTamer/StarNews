//
//  MockArticleDetailsRouter.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 12/07/2025.
//

import UIKit.UIViewController
@testable import ArticleDetails

protocol TestableArticleDetailsRouter: ArticleDetailsRouter {
    var openSafariCallCount: Int { get }
    var presentShareSheetCallCount: Int { get }
}

final class MockArticleDetailsRouter: TestableArticleDetailsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
    private(set) var openSafariCallCount = 0
    private(set) var presentShareSheetCallCount = 0
    
    // MARK: - Navigation Functions
    func openSafari(url: URL) {
        openSafariCallCount += 1
    }
    
    func presentShareSheet(url: URL) {
        presentShareSheetCallCount += 1
    }
}
