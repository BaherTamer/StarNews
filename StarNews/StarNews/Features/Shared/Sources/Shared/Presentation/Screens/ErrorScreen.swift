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
            label: {
                contentLabel
            },
            description: {
                descriptionText
            },
            actions: {
                tryAgainButton
            }
        )
    }
}

// MARK: - Components
extension ErrorScreen {
    private var contentLabel: some View {
        AppLabel(
            "Failed",
            image: Icons.exclamationMarkTriangleFill
        )
        .foregroundStyle(Colors.titlePrimary)
    }

    private var descriptionText: some View {
        Text("An error has occurred, please try again.")
            .foregroundStyle(Colors.titleSecondary)
    }

    private var tryAgainButton: some View {
        Button(
            "Try Again",
            action: action
        )
        .fontWeight(.semibold)
        .tint(.accentColor)
        .buttonStyle(.glass)
    }
}
