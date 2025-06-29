//
//  ArticleDetailsLoader.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct ArticleDetailsLoader: View {
    // MARK: - Constants
    private let article = ArticleDetails.example
    
    // MARK: - Body
    var body: some View {
        AppScrollView {
            VStack {
                headerView
                descriptionView
                divider
                bodyView
                divider
                actionsView
            }
            .shimmering()
        }
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Components
extension ArticleDetailsLoader {
    private var headerView: some View {
        ArticleDetailsHeaderView(article)
    }
    
    private var descriptionView: some View {
        ArticleDetailsDescriptionView(article)
            .padding(.horizontal)
    }
    
    private var divider: some View {
        Divider().padding()
    }
    
    private var bodyView: some View {
        Text(article.summary)
            .padding(.horizontal)
    }
    
    private var actionsView: some View {
        HStack(spacing: Spaces.s16) {
            Text(verbatim: "Share Article")
            Text(verbatim: "Open in Safari")
        }
        .padding()
    }
}
