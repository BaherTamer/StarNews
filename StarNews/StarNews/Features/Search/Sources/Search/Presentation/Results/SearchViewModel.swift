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
    private let useCase: SearchUseCase

    // MARK: - Variables
    var state = ViewState.initial
    var pageInfo = PageInfo.initial
    private(set) var searchResults: [SearchResult] = []

    // MARK: - Life Cycle
    init(
        query: String,
        router: SearchRouter,
        useCase: SearchUseCase
    ) {
        self.query = query
        self.router = router
        self.useCase = useCase
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
            guard let self else { return }
            updateState(.loading)
            do {
                let input = SearchInput(
                    query: query,
                    page: page,
                    limit: limit
                )
                let searchResults = try await useCase.execute(input: input)
                setResults(searchResults)
                updateState(self.searchResults.isEmpty ? .empty : .loaded)
            } catch {
                updateState(.error)
            }
        }
    }
    
    private func setResults(_ data: PaginatedData<SearchResult>) {
        pageInfo = data.pageInfo
        searchResults = data.items
    }
    
    private func resetState() {
        searchResults = []
        pageInfo = .initial
        updateState(.initial)
    }
    
    private func updateState(_ state: ViewState) {
        self.state = state
    }
}
