//
//  ArticleDetailsMapperTests.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import ArticleDetails

final class ArticleDetailsMapperTests {
    // MARK: - Variables
    private let mapper: DefaultArticleDetailsMapper
    
    // MARK: - Life Cycle
    init() {
        self.mapper = DefaultArticleDetailsMapper()
    }
    
    // MARK: - Parsing Tests
    
    @Test private func validData() throws {
        // Given
        let json = MockArticleDetailsJSON.validData
        let data = json.data(using: .utf8)!
        
        // When
        let result = try mapper.parse(data)
        
        // Then
        #expect(result.id == 20)
    }
    
    @Test private func nullablePlaceholders() throws {
        // Given
        let json = MockArticleDetailsJSON.nullableData
        let data = json.data(using: .utf8)!
        
        // When
        let article = try mapper.parse(data)
        
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
        let json = MockArticleDetailsJSON.nullableData
        let data = json.data(using: .utf8)!
        
        // Then
        #expect(throws: (any Error).self) {
            _ = try mapper.parse(data)
        }
    }
}
