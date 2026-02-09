//
//  ArticleDetailsViewModelTests.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 12/07/2025.
//

import Testing
@testable import ArticleDetails

@MainActor
final class ArticleDetailsViewModelTests {
    // MARK: - Variables
    private let viewModel: ArticleDetailsViewModel!
    private let router: TestableArticleDetailsRouter!
    private var useCase: TestableArticleDetailsUseCase!
    
    // MARK: - Life Cycle
    init() {
        self.router = MockArticleDetailsRouter()
        self.useCase = StubArticleDetailsUseCase()
        self.viewModel = ArticleDetailsViewModelImpl(
            articleId: ArticleDetails.example.id,
            router: router,
            articleDetailsUseCase: useCase
        )
    }
    
    // MARK: - View State Tests
    
    @Test private func getArticleDetailsSuccess() async throws {
        // Given
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        try await Task.sleep(nanoseconds: 1_000_000)
        
        // Then
        #expect(viewModel.article != nil)
        #expect(viewModel.state == .loaded)
    }
    
    @Test private func getArticleDetailsFailure() async throws {
        // Given
        useCase.shouldThrowError = true
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        try await Task.sleep(nanoseconds: 1_000_000)
        
        // Then
        #expect(viewModel.article == nil)
        #expect(viewModel.state == .error)
    }
}
