//
//  ArticleCardView.swift
//  ArticlesList
//
//  Created by Baher Tamer on 21/06/2025.
//

import Shared
import SNCore
import SNDesignSystem
import SwiftUI

struct ArticleCardView: View {
    // MARK: - Inputs
    let article: Article
    let onTap: () -> Void

    // MARK: - Body
    var body: some View {
        Button(
            action: onTap,
            label: {
                articleImage
            }
        )
        .overlay(
            alignment: .bottomLeading,
            content: {
                contentContainer
            }
        )
        .clipShape(.rect(cornerRadius: Radii.r16))
    }
}

// MARK: - Components
extension ArticleCardView {
    private var articleImage: some View {
        WebImage(
            urlString: article.imageURL,
            contentMode: .fill
        )
        .frame(
            maxWidth: .infinity,
            minHeight: Sizes.s400,
            maxHeight: Sizes.s400
        )
    }

    private var contentContainer: some View {
        VStack(alignment: .leading) {
            titleText
            dividerView
            footerContainer
        }
        .padding()
        .glassEffect(in: RoundedRectangle(cornerRadius: Radii.r10))
        .padding(Spaces.s6)
    }

    private var titleText: some View {
        Text(article.title)
            .font(.title2)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
            .foregroundStyle(Colors.titlePrimary)
    }

    private var dividerView: some View {
        Divider()
            .foregroundStyle(Colors.dividerPrimary)
            .padding(.bottom)
    }

    private var footerContainer: some View {
        LabeledContent(
            content: {
                shareButton
            },
            label: {
                sourceLabel
            }
        )
    }

    private var sourceLabel: some View {
        AppLabel(
            article.siteName,
            image: Icons.newspaperFill
        )
        .font(.headline)
        .foregroundStyle(Colors.titlePrimary)
    }

    private var shareButton: some View {
        Button(action: shareArticle) {
            Icons.squareAndArrowUp
                .font(.title3)
                .foregroundStyle(Colors.titleSecondary)
        }
    }
}

// MARK: - Private Helpers
extension ArticleCardView {
    private func shareArticle() {
        guard
            let articleURL = URL(string: article.url)
        else { return }
        presentShareSheet(url: articleURL)
    }
}
