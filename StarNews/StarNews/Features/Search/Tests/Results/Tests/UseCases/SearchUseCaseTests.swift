//
//  SearchUseCaseTests.swift
//  Search
//
//  Created by Baher Tamer on 12/07/2025.
//

import Testing
@testable import Search

final class SearchUseCaseTests {
    // MARK: - Variables
    private let input: SearchInput
    private let useCase: SearchUseCase!
    private var repository: TestableSearchRepository!
    
    // MARK: - Life Cycle
    init() {
        self.input = SearchInput(query: "Rocket", page: 1, limit: 10)
        self.repository = StubSearchRepository()
        self.useCase = DefaultSearchUseCase(repository: repository)
    }
    
    // MARK: - Core Tests
    
    @Test private func getSearchSuccess() async throws {
        // When
        let response = try await useCase.execute(input: input)
        
        // Then
        #expect(response.pageInfo.currentPage == input.page)
        #expect(response.pageInfo.pageSize == input.limit)
    }
    
    @Test private func getSearchFailure() async throws {
        // Given
        repository.shouldThrowError = true
        
        // Then
        await #expect(throws: SearchError.repositoryError) {
            _ = try await useCase.execute(input: input)
        }
    }
}
