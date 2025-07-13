//
//  ArticlesRepositoryTests.swift
//  ArticlesList
//
//  Created by Baher Tamer on 13/07/2025.
//

import Testing
@testable import ArticlesList

final class ArticlesRepositoryTests {
    // MARK: - Variables
    private let input: ArticlesInput
    private let endPoint: ArticlesEndpoint
    private let cache: MockArticlesCache
    private var networkService: TestableNetworkService
    private var mapper: any TestableArticlesMapper
    private let repository: ArticlesRepository
    
    // MARK: - Life Cycle
    init() {
        self.input = ArticlesInput(page: 1, limit: 10)
        self.endPoint = ArticlesEndpoint(input: input)
        self.cache = MockArticlesCache()
        self.networkService = StubNetworkService()
        self.mapper = StubArticlesMapper()
        self.repository = DefaultArticlesRepository(
            cache: cache,
            networkService: networkService,
            mapper: mapper
        )
    }
    
    // MARK: - Network Tests
    
    @Test private func networkSuccess() async throws {
        // When
        let paginatedData = try await repository.getArticles(input: input)
        
        // Then
        #expect(paginatedData.items.count == 3)
    }
    
    @Test private func networkFails() async {
        // Given
        networkService.shouldThrowError = true
        
        // Then
        await #expect(throws: ArticlesError.networkError.self) {
            _ = try await repository.getArticles(input: input)
        }
    }
    
    // MARK: - Mapper Tests
    @Test private func mapperSuccess() async throws {
        // When
        let paginatedData = try await repository.getArticles(input: input)
        
        // Then
        #expect(paginatedData.items.count == Article.dummyList.count)
    }
    
    @Test private func mapperFails() async {
        // Given
        mapper.shouldThrowError = true
        
        // Then
        await #expect(throws: ArticlesError.mapperError.self) {
            _ = try await repository.getArticles(input: input)
        }
    }
    
    // MARK: - Network Tests
    
    
}
