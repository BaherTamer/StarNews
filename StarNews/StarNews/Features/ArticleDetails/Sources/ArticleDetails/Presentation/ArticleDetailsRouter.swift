//
//  ArticleDetailsRouter.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import UIKit.UIViewController

protocol ArticleDetailsRouter {
    var screenVC: UIViewController? { get set }
}

final class DefaultArticleDetailsRouter: ArticleDetailsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}
