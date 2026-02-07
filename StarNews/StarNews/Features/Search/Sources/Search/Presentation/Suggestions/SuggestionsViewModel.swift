//
//  SuggestionsViewModel.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import Combine
import Foundation
import Observation
import SNCore

protocol SuggestionsViewModel: ViewModel {
    var query: String { get set }
    var isSearchPresented: Bool { get set }
    var suggestions: [Suggestion] { get }
    
    func didTapSuggestion(with id: Int)
    func onSearchSubmit()
    func onQueryChange(_ oldValue: String, _ newValue: String)
}

@Observable
final class DefaultSuggestionsViewModel: SuggestionsViewModel {
    // MARK: - Inputs
    private let router: SuggestionsRouter
    
    // MARK: - UseCases
    private let suggestionsUseCase: SuggestionsUseCase

    // MARK: - States
    var state = ViewState.initial
    var query: String = ""
    var isSearchPresented: Bool = false
    private(set) var suggestions: [Suggestion] = []
    
    // MARK: - Variables
    private let querySubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life Cycle
    init(
        router: SuggestionsRouter,
        suggestionsUseCase: SuggestionsUseCase
    ) {
        self.router = router
        self.suggestionsUseCase = suggestionsUseCase
        observeQueryChanges()
    }
    
    func onInit() {
        isSearchPresented = true
    }
    
    func errorAction() {
        resetState()
    }
}

// MARK: - Core Functions
extension DefaultSuggestionsViewModel {
    func didTapSuggestion(with id: Int) {
        router.pushArticleDetails(with: id)
    }
    
    func onSearchSubmit() {
        router.pushSearchResults(with: query)
    }
    
    func onQueryChange(_ oldValue: String, _ newValue: String) {
        querySubject.send(newValue)
    }
}

// MARK: - Private Helpers
extension DefaultSuggestionsViewModel {
    private func observeQueryChanges() {
        querySubject
            .debounce(
                for: .milliseconds(500),
                scheduler: DispatchQueue.main
            )
            .removeDuplicates()
            .sink(receiveValue: getSuggestions)
            .store(in: &cancellables)
    }
    
    private func getSuggestions(for query: String) {
        guard !query.isEmpty else {
            resetState()
            return
        }
        
        Task { [weak self] in
            self?.updateState(.loading)
            do {
                let suggestions = try await self?.suggestionsUseCase.execute(query: query) ?? []
                self?.suggestions = suggestions
                self?.updateState(suggestions.isEmpty ? .empty : .loaded)
            } catch {
                self?.updateState(.error)
            }
        }
    }
    
    private func resetState() {
        suggestions = []
        state = .initial
    }
}
