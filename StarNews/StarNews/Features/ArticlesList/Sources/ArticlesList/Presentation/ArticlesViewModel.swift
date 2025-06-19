//
//  ArticlesViewModel.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import Observation
import SNCore

protocol ArticlesViewModel: ViewModel {
    var articles: [Article] { get }
    
    func paginateForward()
    func paginateBackward()
}

@Observable
final class DefaultArticlesViewModel: ArticlesViewModel {
    // MARK: - Inputs
    private let router: ArticlesRouter
    
    // MARK: - UseCases
    private let useCase: ArticlesUseCase

    // MARK: - Variables
    var state = ViewState.initial
    private(set) var articles: [Article] = []
    private var pageInfo = PageInfo.initial

    // MARK: - Life Cycle
    init(
        router: ArticlesRouter,
        useCase: ArticlesUseCase
    ) {
        self.router = router
        self.useCase = useCase
    }

    func onInit() {
        getArticles(
            page: pageInfo.nextPage,
            limit: pageInfo.pageSize
        )
    }
    
    func onRefresh() {
        resetState()
    }
    
    func errorAction() {
        resetState()
    }
    
    func emptyAction() {
        resetState()
    }
}

// MARK: - Core Functions
extension DefaultArticlesViewModel {
    func paginateForward() {
        if pageInfo.shouldPaginateForward {
            getArticles(
                page: pageInfo.nextPage,
                limit: pageInfo.pageSize
            )
        }
    }
    
    func paginateBackward() {
        if pageInfo.shouldPaginateBackward {
            getArticles(
                page: pageInfo.previousPage,
                limit: pageInfo.pageSize
            )
        }
    }
}

// MARK: - Private Helpers
extension DefaultArticlesViewModel {
    private func getArticles(page: Int, limit: Int) {
        Task {
            updateState(.loading)
            do {
                let articles = try await useCase.execute(
                    page: page,
                    limit: limit
                )
                setArticles(articles)
                updateState(self.articles.isEmpty ? .empty : .loaded)
            } catch {
                updateState(.error)
            }
        }
    }
    
    private func setArticles(_ data: PaginatedData<Article>) {
        pageInfo = data.pageInfo
        articles = data.items
    }
    
    private func resetState() {
        articles = []
        pageInfo = .initial
        updateState(.initial)
    }
    
    private func updateState(_ state: ViewState) {
        self.state = state
    }
}
