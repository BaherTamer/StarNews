//
//  SearchRepository.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import OSLog
import Shared
import SNCache
import SNNetwork

protocol SearchRepository: Sendable {
    func getSearchResults(input: SearchInput) async throws -> PaginatedData<SearchResult>
}

final class DefaultSearchRepository<SearchCache: CacheService>: SearchRepository where SearchCache.Value == PaginatedData<SearchResult> {
    // MARK: - Inputs
    private let networkService: NetworkService
    private let cache: SearchCache

    // MARK: - Constants
    private let logger = Logger(
        subsystem: "com.StarNews",
        category: "SearchRepository"
    )

    // MARK: - Life Cycle
    init(
        cache: SearchCache,
        networkService: NetworkService
    ) {
        self.cache = cache
        self.networkService = networkService
    }
}

// MARK: - Base Functions
extension DefaultSearchRepository {
    func getSearchResults(input: SearchInput) async throws -> PaginatedData<SearchResult> {
        let cacheKey = getCacheKey(input: input)
        
        if let cachedResults = getCachedResults(forKey: cacheKey) {
            logger.info("Returning cached search results for page: \(input.page).")
            return cachedResults
        }

        let searchResults = try await getRemoteSearchResults(input: input)
        logger.info("Returning remote search results for page: \(input.page).")
        
        cacheResults(searchResults, forKey: cacheKey)
        return searchResults
    }
}

// MARK: - Private Helpers
extension DefaultSearchRepository {
    private func getRemoteSearchResults(input: SearchInput) async throws -> PaginatedData<SearchResult> {
        let endpoint = SearchEndpoint(input: input)
        let mapper = SearchMapper()
        let response = try await networkService.request(with: endpoint)
        let articles = try mapper.parse(response)
        return articles
    }
}

// MARK: - Cache Helpers
extension DefaultSearchRepository {
    private func getCacheKey(input: SearchInput) -> String {
        "articles/limit=\(input.limit)&page=\(input.page)"
    }

    private func getCachedResults(forKey key: String) -> PaginatedData<SearchResult>? {
        cache.getValue(forKey: key)
    }
    
    private func cacheResults(_ results: PaginatedData<SearchResult>, forKey key: String) {
        cache.setValue(results, forKey: key)
    }
}
