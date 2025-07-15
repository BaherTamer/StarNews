//
//  StubArticleDetailsRepository.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Foundation
@testable import ArticleDetails

protocol TestableArticleDetailsRepository: ArticleDetailsRepository {
    var shouldThrowError: Bool { get set }
}

final class StubArticleDetailsRepository: TestableArticleDetailsRepository {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func getArticleDetails(with id: Int) async throws -> ArticleDetails {
        if shouldThrowError {
            throw ArticleDetailsError.repositoryError
        }
        
        return ArticleDetails.example
    }
}
