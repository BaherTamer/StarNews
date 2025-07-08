//
//  ArticlesViewModelTests.swift
//  ArticlesList
//
//  Created by Baher Tamer on 06/07/2025.
//

import Testing
@testable import ArticlesList

@MainActor
final class ArticlesViewModelTests {
    // MARK: - Variables
    private var viewModel: ArticlesViewModel!
    private var router: TestableArticlesRouter!
    private var useCase: TestableArticlesUseCase!
    
    // MARK: - Life Cycle
    init() {
        self.router = MockArticlesRouter()
        self.useCase = StubArticlesUseCase()
        self.viewModel = DefaultArticlesViewModel(
            router: router,
            useCase: useCase
        )
    }
}

// MARK: - View State Tests
extension ArticlesViewModelTests {
    @Test private func getArticlesSuccess() async throws {
        // Given
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        try await Task.sleep(nanoseconds: 1_000_000)
        
        // Then
        #expect(viewModel.articles.count == Article.dummyList.count)
        #expect(viewModel.state == .loaded)
    }
    
    @Test private func getArticlesEmpty() async throws {
        // Given
        useCase.response = []
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        try await Task.sleep(nanoseconds: 1_000_000)
        
        // Then
        #expect(viewModel.articles.isEmpty)
        #expect(viewModel.state == .empty)
    }
    
    @Test private func getArticlesFailure() async throws {
        // Given
        useCase.shouldThrowError = true
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        try await Task.sleep(nanoseconds: 1_000_000)
        
        // Then
        #expect(viewModel.articles.isEmpty)
        #expect(viewModel.state == .error)
    }
}
