//
//  SearchScreen.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct SearchScreen: View {
    // MARK: - Input
    let viewModel: SearchViewModel
    
    // MARK: - Body
    var body: some View {
        ScreenView {
            stateViews
        }
        .navigationTitle(viewModel.query)
    }
}

// MARK: - View States
extension SearchScreen {
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
        Color.clear
            .onAppear(perform: viewModel.onInit)
    }
    
    private var loadingView: some View {
        SearchLoader()
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
extension SearchScreen {
    private var contentView: some View {
        AppScrollView {
            LazyVStack(spacing: Spaces.s16) {
                searchListView
                paginationView
            }
            .padding(.horizontal)
        }
        .refreshable { viewModel.onRefresh() }
    }
    
    private var searchListView: some View {
        ForEach(
            viewModel.searchResults,
            content: searchCardView
        )
    }
    
    private func searchCardView(_ result: SearchResult) -> some View {
        SearchCardView(
            result: result,
            onTap: {
                viewModel.didTapArticle(with: result.id)
            }
        )
    }
    
    private var paginationView: some View {
        PaginationView(
            pageInfo: viewModel.pageInfo,
            forwardAction: viewModel.paginateForward,
            backwardAction: viewModel.paginateBackward
        )
    }
}
