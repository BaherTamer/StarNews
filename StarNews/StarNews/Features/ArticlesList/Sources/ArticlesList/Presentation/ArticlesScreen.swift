//
//  ArticlesScreen.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct ArticlesScreen: View {
    // MARK: - Input
    let viewModel: ArticlesViewModel
    
    // MARK: - Body
    var body: some View {
        ScreenView {
            stateViews
        }
        .navigationTitle("Latest News")
        .toolbar {
            ToolbarItem(
                placement: .confirmationAction,
                content: searchButton
            )
        }
    }
}

// MARK: - View States
extension ArticlesScreen {
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
        ArticlesLoader()
    }
    
    private var errorView: some View {
        ErrorScreen(
            action: viewModel.errorAction
        )
    }
    
    private var emptyView: some View {
        EmptyScreen(
            content: EmptyContent(
                image: Images.newspaperFill,
                title: "No articles were found!"
            ),
            action: viewModel.emptyAction
        )
    }
}

// MARK: - Components
extension ArticlesScreen {
    private func searchButton() -> some View {
        Button(action: viewModel.didTapSearch) {
            Images.magnifyingGlass
        }
    }
}

// MARK: - SubViews
extension ArticlesScreen {
    private var contentView: some View {
        AppScrollView {
            LazyVStack(spacing: Spaces.s16) {
                articlesListView
                paginationView
            }
            .padding(.horizontal)
        }
        .refreshable { viewModel.onRefresh() }
    }
    
    private var articlesListView: some View {
        ForEach(
            viewModel.articles,
            content: articleCardView
        )
    }
    
    private func articleCardView(_ article: Article) -> some View {
        ArticleCardView(
            article: article,
            onTap: {
                viewModel.didTapArticle(with: article.id)
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
