//
//  StubSuggestionsRepository.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

@testable import Search

protocol TestableSuggestionsRepository: SuggestionsRepository {
    var shouldThrowError: Bool { get set }
}

final class StubSuggestionsRepository: TestableSuggestionsRepository {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func getSuggestions(query: String) async throws -> [Suggestion] {
        if shouldThrowError {
            throw SuggestionsError.repositoryError
        }
        
        return Suggestion.dummyList
    }
}
