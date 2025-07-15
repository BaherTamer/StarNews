//
//  SuggestionsMapperTests.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import Search

final class SuggestionsMapperTests {
    // MARK: - Variables
    private var mapper: any SuggestionsMapper
    
    // MARK: - Life Cycle
    init() {
        mapper = DefaultSuggestionsMapper()
    }
    
    // MARK: - Core Tests
    
    @Test func validData() throws {
        // Given
        let json = MockSuggestionsJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let suggestions = try mapper.parse(data)
        
        // Then
        #expect(suggestions.count == 3)
    }
    
    @Test func nullablePlaceholders() throws {
        // Given
        let json = MockSuggestionsJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let suggestions = try mapper.parse(data)
        let item = suggestions.first!
        
        // Then
        #expect(item.id == -1)
        #expect(item.title == "N/A")
    }
    
    @Test func invalidData() {
        // Given
        let json = MockSuggestionsJSON.validData
        let data = json.data(using: .utf8)!
        
        // Then
        #expect(throws: (any Error).self) {
            _ = try mapper.parse(data)
        }
    }
    
    @Test func emptyData() throws {
        // Given
        let json = MockSuggestionsJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let suggestions = try mapper.parse(data)
        
        // Then
        #expect(suggestions.isEmpty)
    }
}
