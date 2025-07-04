//
//  ArticlesUseCase.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import SNCore

protocol ArticlesUseCase: Sendable {
    func execute(input: ArticlesInput) async throws -> PaginatedData<Article>
}

final class DefaultArticlesUseCase: ArticlesUseCase {
    // MARK: - Inputs
    private let repository: ArticlesRepository

    // MARK: - Life Cycle
    init(repository: ArticlesRepository) {
        self.repository = repository
    }

    // MARK: - Base Functions
    func execute(input: ArticlesInput) async throws -> PaginatedData<Article> {
        try await repository.getArticles(input: input)
    }
}

final class MockArticlesUseCase: ArticlesUseCase {
    func execute(input: ArticlesInput) async throws -> PaginatedData<Article> {
        let articles = Article.dummyList
        let pageInfo = PageInfo(currentPage: 1, pageSize: 3, itemsCount: 3)
        let data: PaginatedData<Article> = PaginatedData(
            items: articles,
            pageInfo: pageInfo
        )
        return data
    }
}
