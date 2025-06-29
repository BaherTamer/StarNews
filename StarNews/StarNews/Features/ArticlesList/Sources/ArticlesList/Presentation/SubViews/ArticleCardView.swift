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
            minHeight: Dimensions.d400,
            maxHeight: Dimensions.d400
        )
    }

    private func contentContainer() -> some View {
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
            .foregroundStyle(Colors.white)
    }

    private var dividerView: some View {
        Divider()
            .background(.primary)
            .padding(.bottom)
            .foregroundStyle(Colors.gray)
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
            image: Images.newspaperFill
        )
        .font(.headline)
        .foregroundStyle(Colors.white)
    }

    private func shareButton() -> some View {
        Button(action: shareArticle) {
            Images.squareAndArrowUp
                .font(.title3)
                .foregroundStyle(Colors.lightGray)
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
