//
//  ArticlesRepository.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import OSLog
import Shared
import SNCache
import SNNetwork

protocol ArticlesRepository: Sendable {
    func getArticles(input: ArticlesInput) async throws -> PaginatedData<Article>
}

final class DefaultArticlesRepository<ArticlesCache: CacheService>: ArticlesRepository where ArticlesCache.Value == PaginatedData<Article> {
    // MARK: - Inputs
    private let networkService: NetworkService
    private let cache: ArticlesCache

    // MARK: - Constants
    private let logger = Logger(
        subsystem: "com.StarNews",
        category: "ArticlesRepository"
    )

    // MARK: - Life Cycle
    init(
        cache: ArticlesCache,
        networkService: NetworkService
    ) {
        self.cache = cache
        self.networkService = networkService
    }
}

// MARK: - Base Functions
extension DefaultArticlesRepository {
    func getArticles(input: ArticlesInput) async throws -> PaginatedData<Article> {
        let cacheKey = getCacheKey(input: input)
        
        if let cachedArticles = getCachedArticles(forKey: cacheKey) {
            logger.info("Returning cached articles for page: \(input.page).")
            return cachedArticles
        }

        let articles = try await getRemoteArticles(input: input)
        logger.info("Returning remote articles for page: \(input.page).")
        
        cacheArticles(articles, forKey: cacheKey)
        return articles
    }
}

// MARK: - Private Helpers
extension DefaultArticlesRepository {
    private func getRemoteArticles(input: ArticlesInput) async throws -> PaginatedData<Article> {
        let endpoint = ArticlesEndpoint(input: input)
        let mapper = ArticlesMapper()
        let response = try await networkService.request(with: endpoint)
        let articles = try mapper.parse(response)
        return articles
    }
}

// MARK: - Cache Helpers
extension DefaultArticlesRepository {
    private func getCacheKey(input: ArticlesInput) -> String {
        "articles/limit=\(input.limit)&page=\(input.page)"
    }

    private func getCachedArticles(forKey key: String) -> PaginatedData<Article>? {
        cache.getValue(forKey: key)
    }
    
    private func cacheArticles(_ articles: PaginatedData<Article>, forKey key: String) {
        cache.setValue(articles, forKey: key)
    }
}
