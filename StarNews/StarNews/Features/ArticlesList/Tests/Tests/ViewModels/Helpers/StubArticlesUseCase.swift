//
//  StubArticlesUseCase.swift
//  ArticlesList
//
//  Created by Baher Tamer on 07/07/2025.
//

import Shared
@testable import ArticlesList

protocol TestableArticlesUseCase: ArticlesUseCase {
    var response: [Article] { get set }
    var shouldThrowError: Bool { get set }
}

final class StubArticlesUseCase: TestableArticlesUseCase {
    // MARK: - Variables
    nonisolated(unsafe) var response = Article.dummyList
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func execute(input: ArticlesInput) async throws -> PaginatedData<Article> {
        if shouldThrowError {
            throw ArticlesError.useCaseError
        }
        
        return PaginatedData(
            items: response,
            pageInfo: .init(
                currentPage: input.page,
                pageSize: input.limit,
                itemsCount: 20
            )
        )
    }
}
