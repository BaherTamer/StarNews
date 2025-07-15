//
//  SuggestionsViewModelTests.swift
//  Search
//
//  Created by Baher Tamer on 12/07/2025.
//

import Testing
@testable import Search

@MainActor
final class SuggestionsViewModelTests {
    // MARK: - Variables
    private var viewModel: (any SuggestionsViewModel)!
    private var router: TestableSuggestionsRouter!
    private var useCase: TestableSuggestionsUseCase!
    
    // MARK: - Life Cycle
    init() {
        self.router = MockSuggestionsRouter()
        self.useCase = StubSuggestionsUseCase()
        self.viewModel = DefaultSuggestionsViewModel(
            router: router,
            useCase: useCase
        )
    }
    
    // MARK: - View State Tests
    
    @Test private func getSuggestionsSuccess() async throws {
        // Given
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        viewModel.query = "StarNews"
        try await Task.sleep(nanoseconds: 400_000_000)
        
        // Then
        #expect(viewModel.suggestions.count == Suggestion.dummyList.count)
        #expect(viewModel.state == .loaded)
    }
    
    @Test private func getSuggestionsEmpty() async throws {
        // Given
        useCase.response = []
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        viewModel.query = "StarNews"
        try await Task.sleep(nanoseconds: 400_000_000)
        
        // Then
        #expect(viewModel.suggestions.isEmpty)
        #expect(viewModel.state == .empty)
    }
    
    @Test private func getSuggestionsFailure() async throws {
        // Given
        useCase.shouldThrowError = true
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        viewModel.query = "StarNews"
        try await Task.sleep(nanoseconds: 400_000_000)
        
        // Then
        #expect(viewModel.suggestions.isEmpty)
        #expect(viewModel.state == .error)
    }
    
    // MARK: - Navigation Tests
    
    @Test private func navigateToArticleDetails() async throws {
        // Given
        #expect(viewModel.state == .initial)
        viewModel.onInit()
        viewModel.query = "StarNews"
        try await Task.sleep(nanoseconds: 400_000_000)
        
        // When
        let article = viewModel.suggestions.first!
        viewModel.didTapSuggestion(with: article.id)
        
        // Then
        #expect(router.navigatedToArticleID == article.id)
    }
    
    @Test private func navigateToSearchResults() async throws {
        // When
        viewModel.onSearchSubmit()
        
        // Then
        #expect(router.didNavigateToSearchResults)
    }
}
