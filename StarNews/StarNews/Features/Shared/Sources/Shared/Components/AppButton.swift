//
//  AppButton.swift
//  Shared
//
//  Created by Baher Tamer on 29/06/2025.
//

import SwiftUI

public struct AppButton: View {
    // MARK: - Inputs
    private let title: String
    private let image: Image
    private let action: () -> Void
    
    // MARK: - Life Cycle
    public init(
        _ title: String,
        image: Image,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.image = image
        self.action = action
    }
    
    // MARK: - Body
    public var body: some View {
        Button(
            action: action,
            label: buttonLabel
        )
    }
}

// MARK: - Components
extension AppButton {
    private func buttonLabel() -> some View {
        AppLabel(title, image: image)
    }
}
