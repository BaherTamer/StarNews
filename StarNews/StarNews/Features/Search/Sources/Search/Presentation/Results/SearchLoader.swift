//
//  SearchLoader.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct SearchLoader: View {
    // MARK: - Body
    var body: some View {
        AppScrollView {
            VStack(spacing: Spaces.s16) {
                ForEach(
                    0..<10,
                    id: \.self,
                    content: searchPlaceholder
                )
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Components
extension SearchLoader {
    private func searchPlaceholder(_ index: Int) -> some View {
        SearchCardView(
            result: SearchResult.dummyList.first!,
            onTap: {}
        )
        .shimmering()
    }
}
