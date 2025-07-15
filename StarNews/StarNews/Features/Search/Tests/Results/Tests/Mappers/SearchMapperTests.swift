//
//  SearchMapperTests.swift
//  Search
//
//  Created by Baher Tamer on 13/07/2025.
//

import Testing
@testable import Search

final class SearchMapperTests {
    // MARK: - Variables
    private let mapper: any SearchMapper
    
    // MARK: - Life Cycle
    init() {
        self.mapper = DefaultSearchMapper()
    }
    
    // MARK: - Core Tests
    
    @Test private func validData() throws {
        // Given
        let json = MockSearchJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(data)
        
        // Then
        #expect(result.items.count == 3)
    }
    
    @Test private func validPageInfo() throws {
        // Given
        let json = MockSearchJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(data)
        let pageInfo = result.pageInfo
        
        // Then
        #expect(pageInfo.currentPage == 2)
        #expect(pageInfo.pageSize == 10)
        #expect(pageInfo.itemsCount == 100)
    }
    
    @Test private func nullablePlaceholders() throws {
        // Given
        let json = MockSearchJSON.nullableData
        let data = json.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(data)
        let item = result.items.first!
        
        // Then
        #expect(item.id == -1)
        #expect(item.title == "N/A")
        #expect(item.imageURL == "")
    }
    
    @Test private func invalidData() {
        // Given
        let json = MockSearchJSON.invalidData
        let data = json.data(using: .utf8)!
        
        // Then
        #expect(throws: (any Error).self) {
            _ = try mapper.parse(data)
        }
    }
    
    @Test private func emptyData() throws {
        // Given
        let json = MockSearchJSON.emptyData
        let data = json.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(data)
        
        // Then
        #expect(result.items.isEmpty)
    }
}
