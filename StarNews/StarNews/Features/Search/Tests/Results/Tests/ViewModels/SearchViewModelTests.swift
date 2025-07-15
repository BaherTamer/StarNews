//
//  SearchViewModelTests.swift
//  Search
//
//  Created by Baher Tamer on 06/07/2025.
//

import Testing
@testable import Search

@MainActor
final class SearchViewModelTests {
    // MARK: - Variables
    private var viewModel: SearchViewModel!
    private var router: TestableSearchRouter!
    private var useCase: TestableSearchUseCase!
    
    // MARK: - Life Cycle
    init() {
        self.router = MockSearchRouter()
        self.useCase = StubSearchUseCase()
        self.viewModel = DefaultSearchViewModel(
            query: "Rocket",
            router: router,
            useCase: useCase
        )
    }
    
    // MARK: - View State Tests
    
    @Test private func getSearchSuccess() async throws {
        // Given
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        await wait()
        
        // Then
        #expect(viewModel.searchResults.count == SearchResult.dummyList.count)
        #expect(viewModel.state == .loaded)
    }
    
    @Test private func getSearchEmpty() async throws {
        // Given
        useCase.response = []
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        await wait()
        
        // Then
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.state == .empty)
    }
    
    @Test private func getSearchFailure() async throws {
        // Given
        useCase.shouldThrowError = true
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        await wait()
        
        // Then
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.state == .error)
    }
    
    // MARK: - Pagination Tests
    
    @Test private func paginateForward() async throws {
        // Given
        #expect(viewModel.state == .initial)
        viewModel.onInit()
        await wait()
        
        // When
        let oldPage = viewModel.pageInfo
        viewModel.paginateForward()
        await wait()
        
        // Then
        #expect(viewModel.pageInfo.currentPage == oldPage.nextPage)
        #expect(viewModel.state == .loaded)
    }
    
    @Test private func paginateBackward() async throws {
        // Given
        #expect(viewModel.state == .initial)
        viewModel.onInit()
        await wait()
        
        // When
        let oldPage = viewModel.pageInfo
        viewModel.paginateForward()
        await wait()
        viewModel.paginateBackward()
        await wait()
        
        // Then
        #expect(viewModel.pageInfo.currentPage == oldPage.currentPage)
        #expect(viewModel.state == .loaded)
    }
    
    // MARK: - Navigation Tests
    
    @Test private func navigateToArticleDetails() async throws {
        // Given
        #expect(viewModel.state == .initial)
        viewModel.onInit()
        await wait()
        
        // When
        let article = viewModel.searchResults.first!
        viewModel.didTapArticle(with: article.id)
        
        // Then
        #expect(router.navigatedToArticleID == article.id)
    }
}

// MARK: - Private Helpers
extension SearchViewModelTests {
    private func wait() async {
        try? await Task.sleep(nanoseconds: 1_000_000)
    }
}
