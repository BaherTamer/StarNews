//
//  SuggestionsEndpointTests.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import Search

final class SuggestionsEndpointTests {
    // MARK: - Variables
    private let query: String
    
    // MARK: - Life Cycle
    init() {
        self.query = "Rocket"
    }
    
    // MARK: - Core Tests
    
    @Test func isGetMethod() {
        // Given
        let endpoint = SuggestionsEndpoint(query: query)
        
        // Then
        #expect(endpoint.method == .get)
    }
    
    @Test func correctPath() {
        // Given
        let endpoint = SuggestionsEndpoint(query: query)
        
        // Then
        #expect(endpoint.path == "articles/")
    }
    
    @Test func correctQueryParams() {
        // Given
        let endpoint = SuggestionsEndpoint(query: query)
        let queryParams = endpoint.queryParams
        
        // Then
        #expect(endpoint.queryParams?["limit"] == "10")
        #expect(endpoint.queryParams?["search"] == query)
        #expect(queryParams?.count == 2)
    }
}
