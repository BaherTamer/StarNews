//
//  MockSearchRouter.swift
//  Search
//
//  Created by Baher Tamer on 07/07/2025.
//

import UIKit.UIViewController
@testable import Search

protocol TestableSearchRouter: SearchRouter {
    var navigatedToArticleID: Int? { get set }
}

final class MockSearchRouter: TestableSearchRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
    var navigatedToArticleID: Int?
    
    // MARK: - Navigation Functions
    func navigateToArticleDetails(with id: Int) {
        navigatedToArticleID = id
    }
}
