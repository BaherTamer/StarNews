//
//  ArticleDetailsRouter.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import SNCore
import UIKit.UIViewController

protocol ArticleDetailsRouter: Router {
    
}

final class DefaultArticleDetailsRouter: ArticleDetailsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}
