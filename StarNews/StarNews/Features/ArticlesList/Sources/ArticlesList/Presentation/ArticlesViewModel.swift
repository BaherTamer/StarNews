//
//  ArticlesViewModel.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation
import Observation
import Shared
import SNCore

protocol ArticlesViewModel: ViewModel {
    var articles: [Article] { get }
    var pageInfo: PageInfo { get }
    
    func paginateForward()
    func paginateBackward()
    func didTapSearch()
    func didTapArticle(with id: Int)
    func shareArticle(urlString: String)
}

@Observable
final class ArticlesViewModelImpl: ArticlesViewModel {
    // MARK: - Inputs
    private let router: ArticlesRouter
    
    // MARK: - UseCases
    private let articlesUseCase: ArticlesUseCase

    // MARK: - Variables
    var state = ViewState.initial
    var pageInfo = PageInfo.initial
    private(set) var articles: [Article] = []

    // MARK: - Life Cycle
    init(
        router: ArticlesRouter,
        articlesUseCase: ArticlesUseCase
    ) {
        self.router = router
        self.articlesUseCase = articlesUseCase
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
extension ArticlesViewModelImpl {
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
    
    func didTapSearch() {
        router.pushSearch()
    }
    
    func didTapArticle(with id: Int) {
        router.pushArticleDetails(with: id)
    }
    
    func shareArticle(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        router.presentShareSheet(url: url)
    }
}

// MARK: - Private Helpers
extension ArticlesViewModelImpl {
    private func getArticles(page: Int, limit: Int) {
        Task { [weak self] in
            self?.updateState(.loading)
            do {
                let input = ArticlesInput(page: page, limit: limit)
                let articles = try await self?.articlesUseCase.execute(input: input)
                self?.setArticles(articles)
                self?.updateState(
                    (self?.articles.isEmpty ?? true) ?
                    .empty :
                    .loaded
                )
            } catch {
                self?.updateState(.error)
            }
        }
    }
    
    private func setArticles(_ data: PaginatedData<Article>?) {
        guard let data else { return }
        pageInfo = data.pageInfo
        articles = data.items
    }
    
    private func resetState() {
        articles = []
        pageInfo = .initial
        updateState(.initial)
    }
}
