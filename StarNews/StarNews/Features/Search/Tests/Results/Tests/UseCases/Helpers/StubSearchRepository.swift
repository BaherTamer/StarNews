//
//  StubSearchRepository.swift
//  Search
//
//  Created by Baher Tamer on 12/07/2025.
//

import Shared
@testable import Search

protocol TestableSearchRepository: SearchRepository {
    var shouldThrowError: Bool { get set }
}

final class StubSearchRepository: TestableSearchRepository {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func getSearchResults(input: SearchInput) async throws -> PaginatedData<SearchResult> {
        if shouldThrowError {
            throw SearchError.repositoryError
        }

        return PaginatedData(
            items: SearchResult.dummyList,
            pageInfo: PageInfo(
                currentPage: input.page,
                pageSize: input.limit,
                itemsCount: 20
            )
        )
    }
}
