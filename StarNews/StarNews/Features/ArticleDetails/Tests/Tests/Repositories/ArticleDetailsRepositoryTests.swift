//
//  ArticleDetailsRepositoryTests.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Testing
@testable import ArticleDetails

final class ArticleDetailsRepositoryTests {
    // MARK: - Variables
    private let articleId: Int
    private let cache: MockArticleDetailsCache
    private let repository: ArticleDetailsRepository!
    private var networkService: TestableNetworkService
    private var mapper: any TestableArticleDetailsMapper
    
    // MARK: - Life Cycle
    init() {
        self.articleId = 20
        self.cache = MockArticleDetailsCache()
        self.networkService = StubNetworkService()
        self.mapper = StubArticleDetailsMapper()
        self.repository = DefaultArticleDetailsRepository(
            cache: cache,
            networkService: networkService,
            mapper: mapper
        )
    }
    
    // MARK: - Core Tests
    
    @Test private func getArticleDetailSuccess() async throws {
        // When
        let article = try await repository.getArticleDetails(with: articleId)
        
        // Then
        #expect(article.id == ArticleDetails.example.id)
    }
    
    // MARK: - Network Tests
    
    @Test private func networkFails() async {
        // Given
        networkService.shouldThrowError = true
        
        // Then
        await #expect(throws: ArticleDetailsError.networkError.self) {
            _ = try await repository.getArticleDetails(with: articleId)
        }
    }
    
    // MARK: - Mapper Tests
    
    @Test private func mapperFails() async {
        // Given
        mapper.shouldThrowError = true
        
        // Then
        await #expect(throws: ArticleDetailsError.mapperError.self) {
            _ = try await repository.getArticleDetails(with: articleId)
        }
    }
    
    // MARK: - Cache Tests
    
    @Test private func cacheExists() async throws {
        // Given
        let key = "articles/\(articleId)"
        let cachedArticle = ArticleDetails.example
        cache.setValue(cachedArticle, forKey: key)
        
        // When
        let result = try await repository.getArticleDetails(with: articleId)
        
        // Then
        #expect(result.id == cachedArticle.id)
    }
    
    @Test private func noCache() async throws {
        // Given
        let key = "articles/\(articleId)"
        let noCachedData = cache.getValue(forKey: key)
        #expect(noCachedData == nil)
        
        // When
        let result = try await repository.getArticleDetails(with: articleId)
        let cachedData = cache.getValue(forKey: key)
        
        // Then
        #expect(cachedData?.id == result.id)
    }
}
