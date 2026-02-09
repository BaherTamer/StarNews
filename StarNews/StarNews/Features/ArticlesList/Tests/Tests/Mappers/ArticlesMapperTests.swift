//
//  ArticlesMapperTests.swift
//  ArticlesList
//
//  Created by Baher Tamer on 13/07/2025.
//

import Testing
@testable import ArticlesList

final class ArticlesMapperTests {
    @Test private func validData() throws {
        // Given
        let json = MockArticlesJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(ArticlesDTO.self)
        let result = response.toDomain()
        
        // Then
        #expect(result.items.count == 3)
    }
    
    @Test private func validPageInfo() throws {
        // Given
        let json = MockArticlesJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(ArticlesDTO.self)
        let result = response.toDomain()
        let pageInfo = result.pageInfo
        
        // Then
        #expect(pageInfo.currentPage == 2)
        #expect(pageInfo.pageSize == 10)
        #expect(pageInfo.itemsCount == 100)
    }
    
    @Test private func nullablePlaceholders() throws {
        // Given
        let json = MockArticlesJSON.nullableData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(ArticlesDTO.self)
        let result = response.toDomain()
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
        let json = MockArticlesJSON.invalidData
        let data = json.data(using: .utf8)!
        
        // Then
        #expect(throws: (any Error).self) {
            _ = try data.decode(ArticlesDTO.self)
        }
    }
    
    @Test private func emptyData() throws {
        // Given
        let json = MockArticlesJSON.emptyData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(ArticlesDTO.self)
        let result = response.toDomain()
        
        // Then
        #expect(result.items.isEmpty)
    }
}
