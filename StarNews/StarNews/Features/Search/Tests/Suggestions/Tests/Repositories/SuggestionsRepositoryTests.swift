//
//  SuggestionsRepositoryTests.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import Search

@MainActor
final class SuggestionsRepositoryTests {
    // MARK: - Variables
    private let query: String
    private let repository: SuggestionsRepository!
    private let networkService: StubSuggestionsNetworkService!
    
    // MARK: - Life Cycle
    init() {
        self.query = "Rocket"
        self.networkService = StubSuggestionsNetworkService()
        self.repository = DefaultSuggestionsRepository(
            networkService: networkService
        )
    }
    
    // MARK: - Network Tests
    
    @Test private func networkSuccess() async throws {
        // When
        let suggestions = try await repository.getSuggestions(query: query)
        
        // Then
        #expect(suggestions.count == Suggestion.dummyList.count)
    }
    
    @Test private func networkFails() async {
        // Given
        networkService.shouldThrowError = true
        
        // Then
        await #expect(throws: SuggestionsError.networkError.self) {
            _ = try await repository.getSuggestions(query: query)
        }
    }
}
