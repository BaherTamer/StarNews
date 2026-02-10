//
//  ArticleDetailsRouter.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import SNCore
import UIKit

protocol ArticleDetailsRouter: Router {
    func openSafari(url: URL)
    func presentShareSheet(url: URL)
}

final class ArticleDetailsRouterImpl: ArticleDetailsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
}

// MARK: - Navigation Functions
extension ArticleDetailsRouterImpl {
    func openSafari(url: URL) {
        UIApplication.shared.open(url)
    }
    
    func presentShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        presentVC(activityViewController)
    }
}
