//
//  ArticleDetailsBodyView.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 27/06/2025.
//

import SNDesignSystem
import SwiftUI

struct ArticleDetailsBodyView: View {
    // MARK: - Inputs
    private let summary: String

    // MARK: - Life Cycle
    init(_ summary: String) {
        self.summary = summary
    }
    
    // MARK: - Body
    var body: some View {
        Text(verbatim: summaryCleaned)
            .foregroundStyle(Colors.white)
    }
}

// MARK: - Private Helpers
extension ArticleDetailsBodyView {
    private var summaryCleaned: String {
        var cleaned = summary

        // 1. Remove any \n at the start of the string
        cleaned = cleaned.replacingOccurrences(
            of: #"^\n+"#,
            with: "",
            options: .regularExpression
        )

        // 2. Trim any spaces at the start of the string
        cleaned = cleaned.replacingOccurrences(
            of: #"^\s+"#,
            with: "",
            options: .regularExpression
        )

        // 3. Duplicate any \n in the middle of the string
        cleaned = cleaned.replacingOccurrences(
            of: #"(?<!^)\n(?!$)"#,
            with: "\n\n",
            options: .regularExpression
        )

        // 4. Remove any […] at the end of the string
        cleaned = cleaned.replacingOccurrences(
            of: #"\s*\[…\]$"#,
            with: "",
            options: .regularExpression
        )

        return cleaned
    }
}
