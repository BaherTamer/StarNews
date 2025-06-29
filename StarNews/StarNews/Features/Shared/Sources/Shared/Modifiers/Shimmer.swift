//
//  Shimmer.swift
//  SharedUI
//
//  Created by Baher Tamer on 19/06/2025.
//

import SNDesignSystem
import SwiftUI

extension View {
    public func shimmering() -> some View {
        modifier(Shimmer())
    }
}

private struct Shimmer: ViewModifier {
    // MARK: - Constants
    private let min: CGFloat = -0.3
    private let max: CGFloat = 1.3
    private let animation: Animation = {
        Animation
            .linear(duration: 1.5)
            .delay(0.25)
            .repeatForever(autoreverses: false)
    }()
    private let gradient = Gradient(colors: [
        Colors.gray.opacity(0.3),
        Colors.gray.opacity(0.6),
        Colors.gray.opacity(0.3),
    ])

    // MARK: - States
    @State private var isInitialState = true
    @Environment(\.layoutDirection) private var layoutDirection

    // MARK: - Body
    public func body(content: Content) -> some View {
        content
            .redacted(reason: .placeholder)
            .mask(linearGradient)
            .animation(animation, value: isInitialState)
            .onAppear(perform: toggleState)
    }
}

// MARK: - Components
extension Shimmer {
    private var linearGradient: some View {
        LinearGradient(
            gradient: gradient,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
}

// MARK: - Private Helpers
extension Shimmer {
    private var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    private var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }

    private func toggleState() {
        isInitialState = false
    }
}
