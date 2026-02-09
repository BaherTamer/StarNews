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
    private let viewModel: (any SuggestionsViewModel)!
    private let router: TestableSuggestionsRouter!
    private var useCase: TestableSuggestionsUseCase!
    
    // MARK: - Life Cycle
    init() {
        self.router = MockSuggestionsRouter()
        self.useCase = StubSuggestionsUseCase()
        self.viewModel = SuggestionsViewModelImpl(
            router: router,
            suggestionsUseCase: useCase
        )
    }
    
    // MARK: - View State Tests
    
    @Test private func getSuggestionsSuccess() async throws {
        // Given
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        viewModel.onQueryChange("", "StarNews")
        try await Task.sleep(nanoseconds: 600_000_000)
        
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
        viewModel.onQueryChange("", "StarNews")
        try await Task.sleep(nanoseconds: 600_000_000)
        
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
        viewModel.onQueryChange("", "StarNews")
        try await Task.sleep(nanoseconds: 600_000_000)
        
        // Then
        #expect(viewModel.suggestions.isEmpty)
        #expect(viewModel.state == .error)
    }
    
    // MARK: - Navigation Tests
    
    @Test private func pushArticleDetails() async throws {
        // Given
        #expect(viewModel.state == .initial)
        viewModel.onInit()
        viewModel.onQueryChange("", "StarNews")
        try await Task.sleep(nanoseconds: 600_000_000)
        
        // When
        let article = viewModel.suggestions.first!
        viewModel.didTapSuggestion(with: article.id)
        
        // Then
        #expect(router.navigatedToArticleID == article.id)
    }
    
    @Test private func pushSearchResults() async throws {
        // When
        viewModel.onSearchSubmit()
        
        // Then
        #expect(router.didNavigateToSearchResults)
    }
}
