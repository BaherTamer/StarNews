//
//  SuggestionsViewModel.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import Combine
import Foundation
import SNCore

protocol SuggestionsViewModel: ViewModel, ObservableObject {
    var query: String { get set }
    var isSearchPresented: Bool { get set }
    var suggestions: [Suggestion] { get }
    
    func didTapSuggestion(with id: Int)
    func onSearchSubmit()
}

final class DefaultSuggestionsViewModel: SuggestionsViewModel {
    // MARK: - Inputs
    private let router: SuggestionsRouter
    
    // MARK: - UseCases
    private let useCase: SuggestionsUseCase

    // MARK: - States
    @Published var state = ViewState.initial
    @Published var query: String = ""
    @Published var isSearchPresented: Bool = false
    @Published private(set) var suggestions: [Suggestion] = []
    
    // MARK: - Variables
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life Cycle
    init(
        router: SuggestionsRouter,
        useCase: SuggestionsUseCase
    ) {
        self.router = router
        self.useCase = useCase
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
        router.navigateToArticleDetails(with: id)
    }
    
    func onSearchSubmit() {
        router.navigateToSearchResults(with: query)
    }
}

// MARK: - Private Helpers
extension DefaultSuggestionsViewModel {
    private func observeQueryChanges() {
        $query
            .debounce(
                for: .milliseconds(300),
                scheduler: RunLoop.main
            )
            .removeDuplicates()
            .sink(receiveValue: updateSuggestions)
            .store(in: &cancellables)
    }
    
    private func updateSuggestions(_ query: String) {
        guard !query.isEmpty else {
            updateState(.initial)
            return
        }
        
        getSuggestions()
    }
    
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
