//
//  ArticleCardView.swift
//  ArticlesList
//
//  Created by Baher Tamer on 21/06/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct ArticleCardView: View {
    // MARK: - Inputs
    let article: Article
    let onTap: () -> Void
    let onShare: () -> Void

    // MARK: - Body
    var body: some View {
        Button(
            action: onTap,
            label: articleImage
        )
        .overlay(
            alignment: .bottomLeading,
            content: contentContainer
        )
        .clipShape(.rect(cornerRadius: Radii.r16))
    }
}

// MARK: - Components
extension ArticleCardView {
    private func articleImage() -> some View {
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

    private func contentContainer() -> some View {
        VStack(alignment: .leading) {
            titleText
            dividerView
            footerContainer
        }
        .padding()
        .glassEffect(in: .rect(cornerRadius: Radii.r10))
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
            content: shareButton,
            label: sourceLabel
        )
    }

    private func sourceLabel() -> some View {
        AppLabel(
            article.siteName,
            image: Icons.newspaperFill
        )
        .font(.headline)
        .foregroundStyle(Colors.titlePrimary)
    }

    private func shareButton() -> some View {
        Button(action: onShare) {
            Icons.squareAndArrowUp
                .font(.title3)
                .foregroundStyle(Colors.titleSecondary)
        }
    }
}
