//
//  ArticlesMapperTests.swift
//  ArticlesList
//
//  Created by Baher Tamer on 13/07/2025.
//

import Testing
@testable import ArticlesList

final class ArticlesMapperTests {
    // MARK: - Variables
    private let mapper: ArticlesMapper
    
    // MARK: - Life Cycle
    init() {
        self.mapper = ArticlesMapper()
    }
    
    // MARK: - Core Tests
    
    @Test private func validData() throws {
        // Given
        let json = MockArticlesJSON.validData.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(json)
        
        // Then
        #expect(result.items.count == 3)
    }
    
    @Test private func validPageInfo() throws {
        // Given
        let json = MockArticlesJSON.validData.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(json)
        let pageInfo = result.pageInfo
        
        // Then
        #expect(pageInfo.currentPage == 2)
        #expect(pageInfo.pageSize == 10)
        #expect(pageInfo.itemsCount == 100)
    }
    
    @Test private func nullablePlaceholders() throws {
        // Given
        let json = MockArticlesJSON.nullableData.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(json)
        let item = result.items.first!
        
        // Then
        #expect(item.id == -1)
        #expect(item.title == "N/A")
        #expect(item.url == "")
        #expect(item.imageURL == "")
        #expect(item.siteName == "N/A")
    }
    
    @Test private func invalidData() {
        // Given
        let json = MockArticlesJSON.invalidData.data(using: .utf8)!
        
        // Then
        #expect(throws: (any Error).self) {
            _ = try mapper.parse(json)
        }
    }
    
    @Test private func emptyData() throws {
        // Given
        let json = MockArticlesJSON.emptyData.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(json)
        
        // Then
        #expect(result.items.isEmpty)
    }
}
