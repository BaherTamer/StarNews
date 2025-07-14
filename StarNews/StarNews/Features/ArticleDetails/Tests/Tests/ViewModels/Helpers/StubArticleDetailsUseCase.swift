//
//  StubArticleDetailsUseCase.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 12/07/2025.
//

import Shared
@testable import ArticleDetails

protocol TestableArticleDetailsUseCase: ArticleDetailsUseCase {
    var shouldThrowError: Bool { get set }
}

final class StubArticleDetailsUseCase: TestableArticleDetailsUseCase {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func execute(id: Int) async throws -> ArticleDetails {
        if shouldThrowError {
            throw ArticleDetailsError.useCaseError
        }
        
        return ArticleDetails.example
    }
}
