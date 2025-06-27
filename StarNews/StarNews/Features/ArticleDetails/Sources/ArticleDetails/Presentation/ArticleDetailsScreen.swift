//
//  ArticleDetailsScreen.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Shared
import SwiftUI

struct ArticleDetailsScreen: View {
    // MARK: - Input
    var viewModel: ArticleDetailsViewModel
    
    // MARK: - Body
    var body: some View {
        Group {
            stateViews
        }
    }
}

// MARK: - View States
extension ArticleDetailsScreen {
    @ViewBuilder
    private var stateViews: some View {
        switch viewModel.state {
        case .initial:
            initialView
        case .loading:
            loadingView
        case .error:
            errorView
        default:
            contentView
        }
    }
    
    private var initialView: some View {
        Color.clear
            .onAppear(perform: viewModel.onInit)
    }
    
    private var loadingView: some View {
        ArticleDetailsLoader()
    }
    
    private var errorView: some View {
        ErrorScreen(
            action: viewModel.errorAction
        )
    }
}

// MARK: - SubViews
extension ArticleDetailsScreen {
    @ViewBuilder
    private var contentView: some View {
        if let article = viewModel.article {
            AppScrollView {
                VStack {
                    headerView(for: article)
                    descriptionView(for: article)
                    divider
                    bodyView(for: article.summary)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
    private func headerView(for article: ArticleDetails) -> some View {
        ArticleDetailsHeaderView(article)
    }
    
    private func descriptionView(for article: ArticleDetails) -> some View {
        ArticleDetailsDescriptionView(article)
            .padding(.horizontal)
    }
    
    private var divider: some View {
        Divider().padding()
    }
    
    private func bodyView(for summary: String) -> some View {
        ArticleDetailsBodyView(summary)
            .padding(.horizontal)
    }
}
