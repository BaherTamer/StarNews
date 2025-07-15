//
//  StubSuggestionsMapper.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

import Foundation.NSData
@testable import Search

protocol TestableSuggestionsMapper: SuggestionsMapper {
    var shouldThrowError: Bool { get set }
}

final class StubSuggestionsMapper: TestableSuggestionsMapper {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func parse(_ data: Data) throws -> [Suggestion] {
        if shouldThrowError {
            throw SuggestionsError.mapperError
        }
        
        return Suggestion.dummyList
    }
}
