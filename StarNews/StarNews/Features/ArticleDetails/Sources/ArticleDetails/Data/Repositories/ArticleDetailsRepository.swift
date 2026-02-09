//
//  ArticleDetailsRepository.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import OSLog
import SNCache
import SNNetwork

protocol ArticleDetailsRepository: Sendable {
    func getArticleDetails(with id: Int) async throws -> ArticleDetails
}

final class ArticleDetailsRepositoryImpl<ArticleCache: CacheService>: ArticleDetailsRepository where ArticleCache.Value == ArticleDetails {
    // MARK: - Inputs
    private let networkService: NetworkService
    private let cache: ArticleCache

    // MARK: - Constants
    private let logger = Logger(
        subsystem: "com.StarNews",
        category: "ArticleDetailsRepository"
    )

    // MARK: - Life Cycle
    init(
        cache: ArticleCache,
        networkService: NetworkService
    ) {
        self.cache = cache
        self.networkService = networkService
    }
}

// MARK: - Base Functions
extension ArticleDetailsRepositoryImpl {
    func getArticleDetails(with id: Int) async throws -> ArticleDetails {
        let cacheKey = getCacheKey(articleId: id)

        if let cachedArticle = getCachedArticle(forKey: cacheKey) {
            logger.info("Returning cached article with id: \(id).")
            return cachedArticle
        }

        let article = try await getRemoteArticle(with: id)
        logger.info("Returning remote article with id: \(id).")

        cacheArticle(article, forKey: cacheKey)
        return article
    }
}

// MARK: - Private Helpers
extension ArticleDetailsRepositoryImpl {
    private func getCachedArticle(forKey key: String) -> ArticleDetails? {
        cache.getValue(forKey: key)
    }

    private func getRemoteArticle(with id: Int) async throws -> ArticleDetails {
        let endpoint = ArticleDetailsEndpoint(id: id)
        let data = try await networkService.request(with: endpoint)
        let response = try data.decode(ArticleDetailsDTO.self)
        let article = response.toDomain()
        return article
    }

    private func cacheArticle(_ article: ArticleDetails, forKey key: String) {
        cache.setValue(article, forKey: key)
    }
}

// MARK: - Private Helpers
extension ArticleDetailsRepositoryImpl {
    private func getCacheKey(articleId: Int) -> String {
        "articles/\(articleId)"
    }
}
