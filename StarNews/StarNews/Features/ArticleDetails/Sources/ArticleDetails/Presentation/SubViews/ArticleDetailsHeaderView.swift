//
//  ArticleDetailsHeaderView.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Shared
import SNDesignSystem
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
            minHeight: Sizes.s400,
            maxHeight: Sizes.s400
        )
        .clipped()
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
                Colors.screenBG.opacity(0.2),
                Colors.screenBG,
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private func contentContainer() -> some View {
        VStack(alignment: .leading, spacing: Spaces.s16) {
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
            .foregroundStyle(Colors.titlePrimary)
    }

    private var sourceLabel:  some View {
        AppLabel(
            article.siteName,
            image: Icons.newspaperFill
        )
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(Colors.titlePrimary)
    }
}
