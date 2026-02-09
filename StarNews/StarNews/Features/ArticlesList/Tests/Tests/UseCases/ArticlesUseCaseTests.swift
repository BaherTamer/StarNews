//
//  ArticlesUseCaseTests.swift
//  ArticlesList
//
//  Created by Baher Tamer on 12/07/2025.
//

import Testing
@testable import ArticlesList

final class ArticlesUseCaseTests {
    // MARK: - Variables
    private let input: ArticlesInput
    private let useCase: ArticlesUseCase!
    private var repository: TestableArticlesRepository!
    
    // MARK: - Life Cycle
    init() {
        self.input = ArticlesInput(page: 1, limit: 10)
        self.repository = StubArticlesRepository()
        self.useCase = ArticlesUseCaseImpl(repository: repository)
    }
    
    // MARK: - Core Tests
    
    @Test private func getArticlesSuccess() async throws {
        // When
        let response = try await useCase.execute(input: input)
        
        // Then
        #expect(response.pageInfo.currentPage == input.page)
        #expect(response.pageInfo.pageSize == input.limit)
    }
    
    @Test private func getArticlesFailure() async throws {
        // Given
        repository.shouldThrowError = true
        
        // Then
        await #expect(throws: ArticlesError.repositoryError) {
            _ = try await useCase.execute(input: input)
        }
    }
}
