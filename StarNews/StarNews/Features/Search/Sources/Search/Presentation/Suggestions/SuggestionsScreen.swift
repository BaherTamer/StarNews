//
//  SuggestionsScreen.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import Shared
import SNCore
import SNDesignSystem
import SwiftUI

struct SuggestionsScreen<ViewModel: SuggestionsViewModel>: View {
    // MARK: - Input
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Body
    var body: some View {
        ScreenView {
            AppScrollView {
                stateViews
                    .frame(maxHeight: .infinity)
            }
            .search(
                $viewModel.query,
                viewState: $viewModel.state,
                isPresented: $viewModel.isSearchPresented,
                onSubmit: viewModel.onSearchSubmit
            )
        }
        .navigationTitle("Search")
        .onAppear(perform: viewModel.onInit)
    }
}

// MARK: - View States
extension SuggestionsScreen {
    @ViewBuilder
    private var stateViews: some View {
        switch viewModel.state {
        case .initial:
            initialView
        case .loading:
            loadingView
        case .error:
            errorView
        case .empty:
            emptyView
        case .loaded:
            contentView
        }
    }
    
    private var initialView: some View {
        EmptyScreen(
            content: EmptyContent(
                image: Images.magnifyingGlass,
                title: "What article are you searching for?"
            )
        )
    }
    
    private var loadingView: some View {
        SuggestionsLoader()
    }
    
    private var errorView: some View {
        ErrorScreen(
            action: viewModel.errorAction
        )
    }
    
    private var emptyView: some View {
        EmptyScreen(
            content: EmptyContent(
                image: Images.magnifyingGlass,
                title: "No results found!"
            )
        )
    }
}

// MARK: - SubViews
extension SuggestionsScreen {
    private var contentView: some View {
        LazyVStack(alignment: .leading, spacing: Spaces.s16) {
            suggestionsListView
        }
        .padding(.horizontal)
        .frame(alignment: .top)
    }
    
    private var suggestionsListView: some View {
        ForEach(
            viewModel.suggestions,
            content: suggestionRow
        )
    }
    
    private func suggestionRow(_ suggestion: Suggestion) -> some View {
        SuggestionRowView(
            suggestion: suggestion,
            onTap: {
                viewModel.didTapSuggestion(with: suggestion.id)
            }
        )
    }
}

private extension View {
    func search(
        _ query: Binding<String>,
        viewState: Binding<ViewState>,
        isPresented: Binding<Bool>,
        onSubmit: @escaping () -> Void
    ) -> some View {
        self
            .scrollDismissesKeyboard(.interactively)
            .defaultScrollAnchor(
                viewState.wrappedValue == .loaded ? .top : .center,
                for: .alignment
            )
            .searchable(text: query, isPresented: isPresented)
            .onSubmit(of: .search, onSubmit)
    }
}
