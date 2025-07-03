//
//  SuggestionsScreen.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct SuggestionsScreen: View {
    // MARK: - Input
    var viewModel: SuggestionsViewModel
    
    // MARK: - Body
    var body: some View {
        ScreenView {
            AppScrollView {
                stateViews
            }
        }
        .navigationTitle("Search")
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
        emptyView
            .onAppear(perform: viewModel.onInit)
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
        AppScrollView {
            LazyVStack(spacing: Spaces.s16) {
                suggestionsListView
            }
            .padding(.horizontal)
        }
        .refreshable { viewModel.onRefresh() }
    }
    
    private var suggestionsListView: some View {
        ForEach(
            viewModel.suggestions,
            content: {
                Text($0.title)
            }
        )
    }
}
