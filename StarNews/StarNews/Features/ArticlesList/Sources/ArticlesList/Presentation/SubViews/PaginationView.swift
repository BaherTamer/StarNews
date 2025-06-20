//
//  PaginationView.swift
//  ArticlesList
//
//  Created by Baher Tamer on 21/06/2025.
//


import SwiftUI

struct PaginationView: View {
    // MARK: - Inputs
    let pageInfo: PageInfo
    let forwardAction: () -> Void
    let backwardAction: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            backwardButton
            currentPageText
            forwardButton
        }
        .font(.headline)
    }
}

// MARK: - Components
extension PaginationView {
    private var backwardButton: some View {
        Button(
            "Back",
            systemImage: "chevron.backward",
            action: backwardAction
        )
        .glassButtonStyle(
            isHidden: !pageInfo.shouldPaginateBackward
        )
    }
    
    private var currentPageText: some View {
        Text(pageInfo.currentPage, format: .number)
            .font(.headline)
            .frame(maxWidth: .infinity)
    }
    
    private var forwardButton: some View {
        Button(
            "Next",
            systemImage: "chevron.forward",
            action: forwardAction
        )
        .glassButtonStyle(
            isHidden: !pageInfo.shouldPaginateForward
        )
    }
}

// MARK: - UI Helpers
private extension View {
    func glassButtonStyle(isHidden: Bool) -> some View {
        self
            .buttonStyle(.glass)
            .labelStyle(.iconOnly)
            .opacity(isHidden ? 0 : 1)
    }
}
