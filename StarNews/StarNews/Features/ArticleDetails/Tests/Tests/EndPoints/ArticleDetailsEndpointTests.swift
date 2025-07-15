//
//  ArticleDetailsEndpointTests.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import ArticleDetails

final class ArticleDetailsEndpointTests {
    // MARK: - Variables
    private let articleId: Int
    
    // MARK: - Life Cycle
    init() {
        self.articleId = 20
    }
    
    // MARK: - Configuration Tests
    
    @Test private func isGetMethod() {
        // Given
        let endpoint = ArticleDetailsEndpoint(id: articleId)

        // Then
        #expect(endpoint.method == .get)
    }
    
    @Test private func endpointPath() {
        // Given
        let endpoint = ArticleDetailsEndpoint(id: articleId)
        let expectedPath = "articles/\(articleId)"
        
        // Then
        #expect(endpoint.path == expectedPath)
    }
}
