//
//  EmptyScreen.swift
//  Shared
//
//  Created by Baher Tamer on 21/06/2025.
//

import SNDesignSystem
import SwiftUI

public struct EmptyContent {
    let icon: String
    let title: String.LocalizationValue

    public init(icon: String, title: String.LocalizationValue) {
        self.icon = icon
        self.title = title
    }
}

public struct EmptyScreen: View {
    // MARK: - Inputs
    private let content: EmptyContent
    private let action: () -> Void

    // MARK: - Life Cycle
    public init(content: EmptyContent, action: @escaping () -> Void) {
        self.content = content
        self.action = action
    }

    // MARK: - Body
    public var body: some View {
        ContentUnavailableView(
            label: contentLabel,
            actions: tryAgainButton
        )
    }
}

// MARK: - Components
extension EmptyScreen {
    private func contentLabel() -> some View {
        Label(
            String(localized: content.title),
            systemImage: content.icon
        )
        .foregroundStyle(Colors.white)
    }

    private func tryAgainButton() -> some View {
        Button(
            "Try Again",
            action: action
        )
        .fontWeight(.semibold)
    }
}
