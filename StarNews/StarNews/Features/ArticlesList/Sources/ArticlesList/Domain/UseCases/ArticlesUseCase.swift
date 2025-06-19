//
//  ArticlesUseCase.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import SNCore

protocol ArticlesUseCase: Sendable {
    func execute(page: Int, limit: Int) async throws -> PaginatedData<Article>
}

final class DefaultArticlesUseCase: ArticlesUseCase {
    // MARK: - Inputs
    private let repository: ArticlesRepository

    // MARK: - Life Cycle
    init(repository: ArticlesRepository) {
        self.repository = repository
    }

    // MARK: - Base Functions
    func execute(page: Int, limit: Int) async throws -> PaginatedData<Article> {
        try await repository.getArticles(page: page, limit: limit)
    }
}

final class MockArticlesUseCase: ArticlesUseCase {
    func execute(page: Int, limit: Int) async throws -> PaginatedData<Article> {
        try? await Task.sleep(for: .seconds(2))
        let articles = Article.dummyList
        let pageInfo = PageInfo(currentPage: 1, pageSize: 3, itemsCount: 3)
        let data: PaginatedData<Article> = PaginatedData(
            items: articles,
            pageInfo: pageInfo
        )
        return data
    }
}
