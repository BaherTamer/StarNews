//
//  ArticleDetailsUseCaseTests.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import ArticleDetails

final class ArticleDetailsUseCaseTests {
    // MARK: - Variables
    private let articleId: Int
    private let useCase: ArticleDetailsUseCase!
    private var repository: TestableArticleDetailsRepository!
    
    // MARK: - Life Cycle
    init() {
        self.articleId = 20
        self.repository = StubArticleDetailsRepository()
        self.useCase = ArticleDetailsUseCaseImpl(repository: repository)
    }
    
    // MARK: - UseCase Tests
    
    @Test private func getArticleDetailsSuccess() async throws {
        // Given
        let expectedArticle = ArticleDetails.example
        
        // When
        let article = try await useCase.execute(id: articleId)
        
        // Then
        #expect(article.id == expectedArticle.id)
    }
    
    @Test private func getArticleDetailsFailure() async {
        // Given
        repository.shouldThrowError = true
        
        // Then
        await #expect(throws: ArticleDetailsError.repositoryError.self) {
            _ = try await useCase.execute(id: articleId)
        }
    }
}
