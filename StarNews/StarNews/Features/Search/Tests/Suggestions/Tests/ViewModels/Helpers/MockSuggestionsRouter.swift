//
//  MockSuggestionsRouter.swift
//  Search
//
//  Created by Baher Tamer on 12/07/2025.
//

import UIKit.UIViewController
@testable import Search

protocol TestableSuggestionsRouter: SuggestionsRouter {
    var didNavigateToSearchResults: Bool { get set }
    var navigatedToArticleID: Int? { get set }
}

final class MockSuggestionsRouter: TestableSuggestionsRouter {
    // MARK: - Variables
    var screenVC: UIViewController?
    var didNavigateToSearchResults = false
    var navigatedToArticleID: Int?
    
    // MARK: - Navigation Functions
    func pushArticleDetails(with id: Int) {
        navigatedToArticleID = id
    }
    
    func pushSearchResults(with query: String) {
        didNavigateToSearchResults = true
    }
}
