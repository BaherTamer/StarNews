//
//  ArticleCardView.swift
//  ArticlesList
//
//  Created by Baher Tamer on 21/06/2025.
//

import Shared
import SNCore
import SwiftUI

struct ArticleCardView: View {
    // MARK: - Inputs
    let article: Article

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
        .overlay(
            alignment: .bottomLeading,
            content: contentContainer
        )
        .clipShape(.rect(cornerRadius: 16))
    }
}

// MARK: - Components
extension ArticleCardView {
    private func overlayGradient() -> LinearGradient {
        LinearGradient(
            colors: [
                .black,
                .black.opacity(0.75),
                .clear,
            ],
            startPoint: .bottom,
            endPoint: .top
        )
    }

    private func contentContainer() -> some View {
        VStack(alignment: .leading) {
            titleText
            dividerView
            footerContainer
        }
        .padding()
        .glassEffect(in: RoundedRectangle(cornerRadius: 10))
        .padding(6)
    }

    private var titleText: some View {
        Text(article.title)
            .font(.title2)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
    }

    private var dividerView: some View {
        Divider()
            .background(.primary)
            .padding(.bottom)
    }

    private var footerContainer: some View {
        LabeledContent(
            content: shareButton,
            label: sourceLabel
        )
    }

    private func sourceLabel() -> some View {
        Label(
            article.siteName,
            systemImage: "newspaper.fill"
        )
        .font(.headline)
    }

    private func shareButton() -> some View {
        Button(action: shareArticle) {
            Image(systemName: "square.and.arrow.up")
                .font(.title3)
                .foregroundStyle(.gray)
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
