//
//  ArticleDetailsUseCase.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import SNCore

protocol ArticleDetailsUseCase: Sendable {
    func execute(id: Int) async throws -> ArticleDetails
}

final class DefaultArticleDetailsUseCase: ArticleDetailsUseCase {
    // MARK: - Inputs
    private let repository: ArticleDetailsRepository

    // MARK: - Life Cycle
    init(repository: ArticleDetailsRepository) {
        self.repository = repository
    }

    // MARK: - Base Functions
    func execute(id: Int) async throws -> ArticleDetails {
        try await repository.getArticleDetails(with: id)
    }
}

final class MockArticleDetails: ArticleDetailsUseCase {
    func execute(id: Int) async throws -> ArticleDetails {
        let article = ArticleDetails.example
        return article
    }
}
