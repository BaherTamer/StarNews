//
//  SearchRepositoryTests.swift
//  Search
//
//  Created by Baher Tamer on 13/07/2025.
//

import Shared
import Testing
@testable import Search

final class SearchRepositoryTests {
    // MARK: - Variables
    private let input: SearchInput
    private let endPoint: SearchEndpoint
    private let cache: MockSearchCache
    private let repository: SearchRepository
    private var networkService: TestableSearchNetworkService
    
    // MARK: - Life Cycle
    init() {
        self.input = SearchInput(query: "Rocket", page: 1, limit: 10)
        self.endPoint = SearchEndpoint(input: input)
        self.cache = MockSearchCache()
        self.networkService = StubSearchNetworkService()
        self.repository = DefaultSearchRepository(
            cache: cache,
            networkService: networkService
        )
    }
    
    // MARK: - Network Tests
    
    @Test private func networkSuccess() async throws {
        // When
        let paginatedData = try await repository.getSearchResults(input: input)
        
        // Then
        #expect(paginatedData.items.count == 3)
    }
    
    @Test private func networkFails() async {
        // Given
        networkService.shouldThrowError = true
        
        // Then
        await #expect(throws: SearchError.networkError.self) {
            _ = try await repository.getSearchResults(input: input)
        }
    }
    
    // MARK: - Cache Tests
    
    @Test private func cacheExists() async throws {
        // Given
        let key = "articles/limit=\(input.limit)&page=\(input.page)&search=\(input.query)"
        let cachedData = PaginatedData(
            items: [SearchResult.dummyList.first!],
            pageInfo: .initial
        )
        cache.setValue(cachedData, forKey: key)
        
        // When
        let result = try await repository.getSearchResults(input: input)
        
        // Then
        #expect(result.items.count == cachedData.items.count)
    }
    
    @Test private func noCache() async throws {
        // Given
        let key = "articles/limit=\(input.limit)&page=\(input.page)&search=\(input.query)"
        let noCachedData = cache.getValue(forKey: key)
        #expect(noCachedData == nil)
        
        // When
        let result = try await repository.getSearchResults(input: input)
        let cachedData = cache.getValue(forKey: key)
        
        // Then
        #expect(cachedData?.items.count == result.items.count)
    }
}
