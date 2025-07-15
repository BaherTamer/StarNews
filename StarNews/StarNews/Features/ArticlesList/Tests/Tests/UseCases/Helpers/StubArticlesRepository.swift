//
//  StubArticlesRepository.swift
//  ArticlesList
//
//  Created by Baher Tamer on 12/07/2025.
//

import Shared
@testable import ArticlesList

protocol TestableArticlesRepository: ArticlesRepository {
    var shouldThrowError: Bool { get set }
}

final class StubArticlesRepository: TestableArticlesRepository {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func getArticles(input: ArticlesInput) async throws -> PaginatedData<Article> {
        if shouldThrowError {
            throw ArticlesError.repositoryError
        }

        return PaginatedData(
            items: Article.dummyList,
            pageInfo: PageInfo(
                currentPage: input.page,
                pageSize: input.limit,
                itemsCount: 20
            )
        )
    }
}
