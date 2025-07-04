//
//  PaginationView.swift
//  ArticlesList
//
//  Created by Baher Tamer on 21/06/2025.
//

import SNDesignSystem
import SwiftUI

public struct PaginationView: View {
    // MARK: - Inputs
    private let pageInfo: PageInfo
    private let forwardAction: () -> Void
    private let backwardAction: () -> Void
    
    // MARK: - Life Cycle
    public init(
        pageInfo: PageInfo,
        forwardAction: @escaping () -> Void,
        backwardAction: @escaping () -> Void
    ) {
        self.pageInfo = pageInfo
        self.forwardAction = forwardAction
        self.backwardAction = backwardAction
    }
    
    // MARK: - Body
    public var body: some View {
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
        AppButton(
            "Back",
            image: Images.chevronBackward,
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
            .foregroundStyle(Colors.white)
    }
    
    private var forwardButton: some View {
        AppButton(
            "Next",
            image: Images.chevronForward,
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
            .tint(Colors.white)
            .opacity(isHidden ? 0 : 1)
    }
}
