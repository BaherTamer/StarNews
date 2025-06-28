//
//  ArticleDetailsHeaderView.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Shared
import SwiftUI

struct ArticleDetailsHeaderView: View {
    // MARK: - Inputs
    private let article: ArticleDetails
    
    // MARK: - Life Cycle
    init(_ article: ArticleDetails) {
        self.article = article
    }
    
    // MARK: - Body
    var body: some View {
        WebImage(
            urlString: article.imageURL,
            contentMode: .fill
        )
        .frame(
            maxWidth: .infinity,
            minHeight: 400,
            maxHeight: 400
        )
        .overlay(content: overlayGradient)
        .overlay(
            alignment: .bottomLeading,
            content: contentContainer
        )
    }
}

// MARK: - Components
extension ArticleDetailsHeaderView {
    private func overlayGradient() -> LinearGradient {
        LinearGradient(
            colors: [
                .clear,
                .black.opacity(0.1),
                .black,
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private func contentContainer() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            sourceLabel
            titleText
        }
        .padding()
    }
    
    private var titleText:  some View {
        Text(article.title)
            .font(.title2)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
    }

    private var sourceLabel:  some View {
        Label(
            article.siteName,
            systemImage: "newspaper.fill"
        )
        .font(.headline)
    }
}
