//
//  ArticlesLoader.swift
//  ArticlesList
//
//  Created by Baher Tamer on 21/06/2025.
//

import Shared
import SwiftUI

struct ArticlesLoader: View {
    // MARK: - Body
    var body: some View {
        AppScrollView {
            VStack(spacing: 16) {
                ForEach(
                    0..<3,
                    id: \.self,
                    content: articlePlaceholder
                )
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Components
extension ArticlesLoader {
    private func articlePlaceholder(_ index: Int) -> some View {
        ArticleCardView(
            article: Article.dummyList.first!,
            onTap: {}
        )
        .shimmering()
    }
}
