//
//  ArticlesRepository.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import OSLog
import SNCache
import SNCore
import SNNetwork

protocol ArticlesRepository {
    func getArticles(page: Int, limit: Int) async throws -> PaginatedData<Article>
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
    func getArticles(page: Int, limit: Int) async throws -> PaginatedData<Article> {
        let cacheKey = getCacheKey(page: page, limit: limit)
        
        if let cachedArticles = getCachedArticles(forKey: cacheKey) {
            logger.info("Returning cached articles for page: \(page).")
            return cachedArticles
        }

        let articles = try await getRemoteArticles(page: page, limit: limit)
        logger.info("Returning remote articles for page: \(page).")
        
        cacheArticles(articles, forKey: cacheKey)
        return articles
    }
}

// MARK: - Private Helpers
extension DefaultArticlesRepository {
    private func getRemoteArticles(page: Int, limit: Int) async throws -> PaginatedData<Article> {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // For Loader animation only
        let endpoint = ArticlesEndpoint(page: page, limit: limit)
        let mapper = ArticlesMapper()
        let response = try await networkService.request(with: endpoint)
        let articles = try mapper.parse(response)
        return articles
    }
}

// MARK: - Cache Helpers
extension DefaultArticlesRepository {
    private func getCacheKey(page: Int, limit: Int) -> String {
        "articles/limit=\(limit)&page=\(page)"
    }

    private func getCachedArticles(forKey key: String) -> PaginatedData<Article>? {
        cache.getValue(forKey: key)
    }
    
    private func cacheArticles(_ articles: PaginatedData<Article>, forKey key: String) {
        cache.setValue(articles, forKey: key)
    }
}
