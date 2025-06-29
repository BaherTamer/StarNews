//
//  ScreenView.swift
//  Shared
//
//  Created by Baher Tamer on 29/06/2025.
//

import SNDesignSystem
import SwiftUI

public struct ScreenView<Content: View>: View {
    // MARK: - Inputs
    private let content: Content
    
    // MARK: - Life Cycle
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        Group {
            content
        }
        .background(
            Colors.darkGray,
            ignoresSafeAreaEdges: .all
        )
    }
}
