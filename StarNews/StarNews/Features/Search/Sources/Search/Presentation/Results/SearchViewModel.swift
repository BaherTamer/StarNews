//
//  SearchViewModel.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import Observation
import Shared
import SNCore

protocol SearchViewModel: ViewModel {
    var query: String { get }
    var searchResults: [SearchResult] { get }
    var pageInfo: PageInfo { get }
    
    func paginateForward()
    func paginateBackward()
    func didTapArticle(with id: Int)
}

@Observable
final class DefaultSearchViewModel: SearchViewModel {
    // MARK: - Inputs
    let query: String
    private let router: SearchRouter
    
    // MARK: - UseCases
    private let searchUseCase: SearchUseCase

    // MARK: - Variables
    var state = ViewState.initial
    var pageInfo = PageInfo.initial
    private(set) var searchResults: [SearchResult] = []

    // MARK: - Life Cycle
    init(
        query: String,
        router: SearchRouter,
        searchUseCase: SearchUseCase
    ) {
        self.query = query
        self.router = router
        self.searchUseCase = searchUseCase
    }

    func onInit() {
        getSearchResults(
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
extension DefaultSearchViewModel {
    func paginateForward() {
        if pageInfo.shouldPaginateForward {
            getSearchResults(
                page: pageInfo.nextPage,
                limit: pageInfo.pageSize
            )
        }
    }
    
    func paginateBackward() {
        if pageInfo.shouldPaginateBackward {
            getSearchResults(
                page: pageInfo.previousPage,
                limit: pageInfo.pageSize
            )
        }
    }
    
    func didTapArticle(with id: Int) {
        router.navigateToArticleDetails(with: id)
    }
}

// MARK: - Private Helpers
extension DefaultSearchViewModel {
    private func getSearchResults(page: Int, limit: Int) {
        Task { [weak self] in
            self?.updateState(.loading)
            do {
                let input = SearchInput(
                    query: self?.query ?? "",
                    page: page,
                    limit: limit
                )
                let searchResults = try await self?.searchUseCase.execute(input: input)
                self?.setResults(searchResults)
                self?.updateState(
                    (self?.searchResults.isEmpty ?? true) ?
                    .empty :
                    .loaded
                )
            } catch {
                self?.updateState(.error)
            }
        }
    }
    
    private func setResults(_ data: PaginatedData<SearchResult>?) {
        guard let data else { return }
        pageInfo = data.pageInfo
        searchResults = data.items
    }
    
    private func resetState() {
        searchResults = []
        pageInfo = .initial
        updateState(.initial)
    }
}
