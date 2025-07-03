//
//  SuggestionRowView.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import SNDesignSystem
import SwiftUI

struct SuggestionRowView: View {
    // MARK: - Inputs
    let suggestion: Suggestion
    let onTap: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: Spaces.s16) {
            rowButton
            divider
        }
    }
}

// MARK: - Components
extension SuggestionRowView {
    private var rowButton: some View {
        Button(
            action: onTap,
            label: titleText
        )
        .tint(Colors.white)
    }
    
    private func titleText() -> some View {
        Text(verbatim: suggestion.title)
            .multilineTextAlignment(.leading)
    }
    
    private var divider: some View {
        Divider()
            .foregroundStyle(Colors.gray)
    }
}
