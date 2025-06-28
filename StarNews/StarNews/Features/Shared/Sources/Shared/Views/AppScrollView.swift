//
//  AppScrollView.swift
//  Shared
//
//  Created by Baher Tamer on 27/06/2025.
//

import SwiftUI

public struct AppScrollView<Content: View>: View {
    // MARK: - Inputs
    private let content: Content
    
    // MARK: - Life Cycle
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        ScrollView {
            content
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
    }
}
