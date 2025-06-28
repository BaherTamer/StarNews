//
//  ArticleDetailsDescriptionView.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import SwiftUI

struct ArticleDetailsDescriptionView: View {
    // MARK: - Inputs
    private let article: ArticleDetails
    
    // MARK: - Variables
    private var dateFormatted: String {
        article.publishDate.formatted(
            .relative(
                presentation: .named,
                unitsStyle: .wide
            )
        )
    }
    
    // MARK: - Life Cycle
    init(_ article: ArticleDetails) {
        self.article = article
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            authorsContainer
            Spacer()
            relativeDateText
        }
    }
}

// MARK: - Components
extension ArticleDetailsDescriptionView {
    private var authorsContainer: some View {
        VStack(alignment: .leading) {
            authorsText
            authorsListText
        }
    }
    
    private var authorsText: some View {
        Text("Authors")
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
    }
    
    private var authorsListText: some View {
        Text(article.authors, format: .list(type: .and))
            .font(.footnote)
    }
    
    private var relativeDateText: some View {
        Text(verbatim: dateFormatted)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
    }
}
