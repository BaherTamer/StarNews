//
//  ErrorScreen.swift
//  Shared
//
//  Created by Baher Tamer on 21/06/2025.
//

import SNDesignSystem
import SwiftUI

public struct ErrorScreen: View {
    // MARK: - Inputs
    private let action: () -> Void

    // MARK: - Life Cycle
    public init(action: @escaping () -> Void) {
        self.action = action
    }

    // MARK: - Body
    public var body: some View {
        ContentUnavailableView(
            label: contentLabel,
            description: descriptionText,
            actions: tryAgainButton
        )
    }
}

// MARK: - Components
extension ErrorScreen {
    private func contentLabel() -> some View {
        Label(
            "Failed",
            systemImage: "exclamationmark.triangle.fill"
        )
        .foregroundStyle(Colors.white)
    }

    private func descriptionText() -> some View {
        Text("An error has occurred, please try again.")
            .foregroundStyle(Colors.lightGray)
    }

    private func tryAgainButton() -> some View {
        Button(
            "Try Again",
            action: action
        )
        .fontWeight(.semibold)
    }
}
