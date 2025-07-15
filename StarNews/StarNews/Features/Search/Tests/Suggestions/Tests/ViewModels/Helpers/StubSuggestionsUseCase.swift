//
//  StubSuggestionsUseCase.swift
//  Search
//
//  Created by Baher Tamer on 12/07/2025.
//

import Shared
@testable import Search

protocol TestableSuggestionsUseCase: SuggestionsUseCase {
    var response: [Suggestion] { get set }
    var shouldThrowError: Bool { get set }
}

final class StubSuggestionsUseCase: TestableSuggestionsUseCase {
    // MARK: - Variables
    nonisolated(unsafe) var response = Suggestion.dummyList
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func execute(query: String) async throws -> [Suggestion] {
        if shouldThrowError {
            throw SuggestionsError.useCaseError
        }
        
        return response
    }
}
