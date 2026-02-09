//
//  SuggestionsUseCaseTests.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import Search

@MainActor
final class SuggestionsUseCaseTests {
    // MARK: - Variables
    private let query: String
    private let useCase: SuggestionsUseCase!
    private var repository: TestableSuggestionsRepository!
    
    // MARK: - Life Cycle
    init() {
        self.query = "Rocket"
        self.repository = StubSuggestionsRepository()
        self.useCase = SuggestionsUseCaseImpl(repository: repository)
    }
    
    // MARK: - Tests
    
    @Test private func getSuggestionsSuccess() async throws {
        // When
        let suggestions = try await useCase.execute(query: query)
        
        // Then
        #expect(suggestions.count == Suggestion.dummyList.count)
    }
    
    @Test private func getSuggestionsFailure() async throws {
        // Given
        repository.shouldThrowError = true
        
        // Then
        await #expect(throws: SuggestionsError.repositoryError) {
            _ = try await useCase.execute(query: query)
        }
    }
}
