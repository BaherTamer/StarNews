//
//  SearchEndpointTests.swift
//  Search
//
//  Created by Baher Tamer on 13/07/2025.
//

import Testing
@testable import Search

final class SearchEndpointTests {
    // MARK: - Variables
    private let input: SearchInput
    
    // MARK: - Life Cycle
    init() {
        self.input = SearchInput(
            query: "Rocket",
            page: 1,
            limit: 10
        )
    }
    
    // MARK: - Core Tests
    
    @Test private func isGetMethod() {
        // Given
        let endpoint = SearchEndpoint(input: input)

        // Then
        #expect(endpoint.method == .get)
    }

    @Test private func correctPath() {
        // Given
        let endpoint = SearchEndpoint(input: input)

        // Then
        #expect(endpoint.path == "articles/")
    }

    @Test private func correctQueryParams() {
        // Given
        let endpoint = SearchEndpoint(input: input)
        let queryParams = endpoint.queryParams

        // Then
        #expect(queryParams?["limit"] == input.limit.description)
        #expect(queryParams?["offset"] == input.offset.description)
        #expect(queryParams?["search"] == input.query)
        #expect(queryParams?.count == 3)
    }
}
