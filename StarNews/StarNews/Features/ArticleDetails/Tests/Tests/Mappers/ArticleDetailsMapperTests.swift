//
//  ArticleDetailsMapperTests.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import ArticleDetails

final class ArticleDetailsMapperTests {
    @Test private func validData() throws {
        // Given
        let json = MockArticleDetailsJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(ArticleDetailsDTO.self)
        let result = response.toDomain()
        
        // Then
        #expect(result.id == 20)
    }
    
    @Test private func nullablePlaceholders() throws {
        // Given
        let json = MockArticleDetailsJSON.nullableData
        let data = json.data(using: .utf8)!
        
        // When
        let response = try data.decode(ArticleDetailsDTO.self)
        let article = response.toDomain()
        
        // Then
        #expect(article.id == -1)
        #expect(article.title == "N/A")
        #expect(article.url == "")
        #expect(article.imageURL == "")
        #expect(article.siteName == "N/A")
        #expect(article.summary == "")
        #expect(article.authors.isEmpty)
    }
    
    @Test private func invalidData() {
        let json = MockArticleDetailsJSON.invalidData
        let data = json.data(using: .utf8)!
        
        // Then
        #expect(throws: (any Error).self) {
            _ = try data.decode(ArticleDetailsDTO.self)
        }
    }
}
