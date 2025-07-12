//
//  StubSearchUseCase.swift
//  Search
//
//  Created by Baher Tamer on 07/07/2025.
//

import Shared
@testable import Search

protocol TestableSearchUseCase: SearchUseCase {
    var response: [SearchResult] { get set }
    var shouldThrowError: Bool { get set }
}

final class StubSearchUseCase: TestableSearchUseCase {
    // MARK: - Variables
    nonisolated(unsafe) var response = SearchResult.dummyList
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func execute(input: SearchInput) async throws -> PaginatedData<SearchResult> {
        if shouldThrowError {
            throw SearchError.useCaseError
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
