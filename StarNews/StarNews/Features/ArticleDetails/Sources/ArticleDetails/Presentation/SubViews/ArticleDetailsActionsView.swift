//
//  ArticleDetailsActionsView.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 27/06/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct ArticleDetailsActionsView: View {
    // MARK: - Inputs
    private let articleURL: String
    
    // MARK: - Variables
    
    @Environment(\.openURL) private var openURL
    
    // MARK: - Life Cycle
    init(articleURL: String) {
        self.articleURL = articleURL
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            shareButton
            safariButton
        }
        .buttonStyle(.glass)
        .tint(Colors.white)
    }
}

// MARK: - Components
extension ArticleDetailsActionsView {
    private var shareButton: some View {
        AppButton(
            "Share Article",
            image: Images.squareAndArrowUp,
            action: shareArticle
        )
    }
    
    private var safariButton: some View {
        AppButton(
            "Open in Safari",
            image: Images.safari,
            action: openLinkInSafari
        )
    }
}

// MARK: - Private Helpers
extension ArticleDetailsActionsView {
    private func shareArticle() {
        guard
            let url = URL(string: articleURL)
        else { return }
        presentShareSheet(url: url)
    }
    
    private func openLinkInSafari() {
        guard
            let url = URL(string: articleURL)
        else { return }
        openURL(url)
    }
}
