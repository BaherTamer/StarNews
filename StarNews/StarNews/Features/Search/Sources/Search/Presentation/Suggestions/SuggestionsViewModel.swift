//
//  SuggestionsViewModel.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import Observation
import SNCore

protocol SuggestionsViewModel: ViewModel {
    var query: String { get set }
    var suggestions: [Suggestion] { get }
    
    func didTapSuggestion(with id: Int)
}

@Observable
final class DefaultSuggestionsViewModel: SuggestionsViewModel {
    // MARK: - Inputs
    private let router: SuggestionsRouter
    
    // MARK: - UseCases
    private let useCase: SuggestionsUseCase

    // MARK: - Variables
    var state = ViewState.initial
    var query: String = ""
    private(set) var suggestions: [Suggestion] = []

    // MARK: - Life Cycle
    init(
        router: SuggestionsRouter,
        useCase: SuggestionsUseCase
    ) {
        self.router = router
        self.useCase = useCase
    }

    func onInit() {
        state = .empty
    }
    
    func errorAction() {
        resetState()
    }
}

// MARK: - Core Functions
extension DefaultSuggestionsViewModel {
    func didTapSuggestion(with id: Int) {
        router.navigateToArticleDetails(with: id)
    }
}

// MARK: - Private Helpers
extension DefaultSuggestionsViewModel {
    private func getSuggestions() {
        Task { [weak self] in
            guard let self else { return }
            updateState(.loading)
            do {
                let suggestions = try await useCase.execute(
                    query: query,
                )
                setSuggestions(suggestions)
                updateState(suggestions.isEmpty ? .empty : .loaded)
            } catch {
                updateState(.error)
            }
        }
    }
    
    private func setSuggestions(_ suggestions: [Suggestion]) {
        self.suggestions = suggestions
    }
    
    private func resetState() {
        suggestions = []
        updateState(.initial)
    }
    
    private func updateState(_ state: ViewState) {
        self.state = state
    }
}
