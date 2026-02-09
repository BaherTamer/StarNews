//
//  SuggestionsDTOTests.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import Search

final class SuggestionsMapperTests {
    @Test private func validData() throws {
        // Given
        let json = MockSuggestionsJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(SuggestionsDTO.self)
        let suggestions = response.toDomain()
        
        // Then
        #expect(suggestions.count == 3)
    }
    
    @Test private func nullablePlaceholders() throws {
        // Given
        let json = MockSuggestionsJSON.nullableData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(SuggestionsDTO.self)
        let suggestions = response.toDomain()
        let item = suggestions.first!
        
        // Then
        #expect(item.id == -1)
        #expect(item.title == "N/A")
    }
    
    @Test private func invalidData() {
        // Given
        let json = MockSuggestionsJSON.invalidData
        let data = json.data(using: .utf8)!
        
        // Then
        #expect(throws: (any Error).self) {
            _ = try data.decode(SuggestionsDTO.self)
        }
    }
    
    @Test private func emptyData() throws {
        // Given
        let json = MockSuggestionsJSON.emptyData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(SuggestionsDTO.self)
        let suggestions = response.toDomain()
        
        // Then
        #expect(suggestions.isEmpty)
    }
}
