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
    private let onShareArticle: () -> Void
    private let onOpenSafari: () -> Void
    
    // MARK: - Life Cycle
    init(
        onShareArticle: @escaping () -> Void,
        onOpenSafari: @escaping () -> Void
    ) {
        self.onShareArticle = onShareArticle
        self.onOpenSafari = onOpenSafari
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: Spaces.s16) {
            shareButton
            safariButton
        }
        .buttonStyle(.glass)
        .tint(Colors.titlePrimary)
    }
}

// MARK: - Components
extension ArticleDetailsActionsView {
    private var shareButton: some View {
        AppButton(
            "Share Article",
            image: Icons.squareAndArrowUp,
            action: onShareArticle
        )
    }
    
    private var safariButton: some View {
        AppButton(
            "Open in Safari",
            image: Icons.safari,
            action: onOpenSafari
        )
    }
}
