//
//  SearchUseCase.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import Shared

protocol SearchUseCase: Sendable {
    func execute(input: SearchInput) async throws -> PaginatedData<SearchResult>
}

final class DefaultSearchUseCase: SearchUseCase {
    // MARK: - Inputs
    private let repository: SearchRepository

    // MARK: - Life Cycle
    init(repository: SearchRepository) {
        self.repository = repository
    }

    // MARK: - Base Functions
    func execute(input: SearchInput) async throws -> PaginatedData<SearchResult> {
        try await repository.getSearchResults(input: input)
    }
}

final class MockSearchUseCase: SearchUseCase {
    func execute(input: SearchInput) async throws -> PaginatedData<SearchResult> {
        let articles = SearchResult.dummyList
        let pageInfo = PageInfo(currentPage: 1, pageSize: 3, itemsCount: 3)
        let data: PaginatedData<SearchResult> = PaginatedData(
            items: articles,
            pageInfo: pageInfo
        )
        return data
    }
}
