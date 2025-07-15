//
//  ArticlesLoader.swift
//  ArticlesList
//
//  Created by Baher Tamer on 21/06/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct ArticlesLoader: View {
    // MARK: - Body
    var body: some View {
        AppScrollView {
            VStack(spacing: Spaces.s16) {
                ForEach(0..<3, id: \.self) { _ in
                    articlePlaceholder
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Components
extension ArticlesLoader {
    private var articlePlaceholder: some View {
        ArticleCardView(
            article: Article.dummyList.first!,
            onTap: {}
        )
        .shimmering()
    }
}
