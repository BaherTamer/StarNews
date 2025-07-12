//
//  MockArticleDetailsRouter.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 12/07/2025.
//

import UIKit.UIViewController
@testable import ArticleDetails

protocol TestableArticleDetailsRouter: ArticleDetailsRouter {
    
}

final class MockArticleDetailsRouter: TestableArticleDetailsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}
