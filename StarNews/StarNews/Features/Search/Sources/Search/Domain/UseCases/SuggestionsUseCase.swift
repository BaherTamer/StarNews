//
//  SuggestionsUseCase.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import SNCore

protocol SuggestionsUseCase: Sendable {
    func execute(query: String) async throws -> [Suggestion]
}

final class DefaultSuggestionsUseCase: SuggestionsUseCase {
    // MARK: - Inputs
    private let repository: SuggestionsRepository

    // MARK: - Life Cycle
    init(repository: SuggestionsRepository) {
        self.repository = repository
    }

    // MARK: - Base Functions
    func execute(query: String) async throws -> [Suggestion] {
        try await repository.getSuggestions(query: query)
    }
}

final class MockSuggestionsUseCase: SuggestionsUseCase {
    func execute(query: String) async throws -> [Suggestion] {
        let suggestions = Suggestion.dummyList
        return suggestions
    }
}
