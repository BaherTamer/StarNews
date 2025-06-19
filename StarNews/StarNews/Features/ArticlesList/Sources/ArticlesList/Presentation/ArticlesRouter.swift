//
//  ArticlesRouter.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import UIKit.UIViewController

protocol ArticlesRouter {
    var screenVC: UIViewController? { get set }
}

final class DefaultArticlesRouter: ArticlesRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}
