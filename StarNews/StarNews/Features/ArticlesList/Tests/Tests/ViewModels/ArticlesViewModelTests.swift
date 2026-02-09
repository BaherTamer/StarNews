//
//  ArticlesViewModelTests.swift
//  ArticlesList
//
//  Created by Baher Tamer on 06/07/2025.
//

import Testing
@testable import ArticlesList

@MainActor
final class ArticlesViewModelTests {
    // MARK: - Variables
    private let viewModel: ArticlesViewModel!
    private let router: TestableArticlesRouter!
    private var useCase: TestableArticlesUseCase!
    
    // MARK: - Life Cycle
    init() {
        self.router = MockArticlesRouter()
        self.useCase = StubArticlesUseCase()
        self.viewModel = DefaultArticlesViewModel(
            router: router,
            articlesUseCase: useCase
        )
    }
    
    // MARK: - View State Tests
    
    @Test private func getArticlesSuccess() async throws {
        // Given
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        await wait()
        
        // Then
        #expect(viewModel.articles.count == Article.dummyList.count)
        #expect(viewModel.state == .loaded)
    }
    
    @Test private func getArticlesEmpty() async throws {
        // Given
        useCase.response = []
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        await wait()
        
        // Then
        #expect(viewModel.articles.isEmpty)
        #expect(viewModel.state == .empty)
    }
    
    @Test private func getArticlesFailure() async throws {
        // Given
        useCase.shouldThrowError = true
        #expect(viewModel.state == .initial)
        
        // When
        viewModel.onInit()
        await wait()
        
        // Then
        #expect(viewModel.articles.isEmpty)
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
    
    @Test private func pushArticleDetails() async throws {
        // Given
        #expect(viewModel.state == .initial)
        viewModel.onInit()
        await wait()
        
        // When
        let article = viewModel.articles.first!
        viewModel.didTapArticle(with: article.id)
        
        // Then
        #expect(router.navigatedToArticleID == article.id)
    }
    
    @Test private func pushSearch() async throws {
        // When
        viewModel.didTapSearch()
        
        // Then
        #expect(router.didNavigateToSearch)
    }
}

// MARK: - Private Helpers
extension ArticlesViewModelTests {
    private func wait() async {
        try? await Task.sleep(nanoseconds: 1_000_000)
    }
}
