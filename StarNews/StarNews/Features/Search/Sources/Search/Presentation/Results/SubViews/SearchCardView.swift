//
//  SearchCardView.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import Shared
import SNDesignSystem
import SwiftUI

struct SearchCardView: View {
    // MARK: - Inputs
    let result: SearchResult
    let onTap: () -> Void
    
    // MARK: - Variables
    private var dateFormatted: String {
        result.publishDate.formatted(
            .relative(
                presentation: .named,
                unitsStyle: .wide
            )
        )
    }

    // MARK: - Body
    var body: some View {
        Button(
            action: onTap,
            label: contentView
        )
    }
}

// MARK: - Components
extension SearchCardView {
    private func contentView() -> some View {
        HStack(spacing: Spaces.s12) {
            articleImage
            textContainer
            Spacer()
        }
        .padding(Spaces.s10)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: Radii.r16)
        )
    }
    
    private var articleImage: some View {
        WebImage(
            urlString: result.imageURL,
            contentMode: .fill
        )
        .frame(
            width: Dimensions.d100,
            height: Dimensions.d100
        )
        .clipShape(RoundedRectangle(cornerRadius: Radii.r10))
    }
    
    private var textContainer: some View {
        VStack(alignment: .leading, spacing: Spaces.s12) {
            relativeDateText
            titleText
        }
    }
    
    private var relativeDateText: some View {
        Text(verbatim: dateFormatted)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundStyle(Colors.lightGray)
    }

    private var titleText: some View {
        Text(result.title)
            .font(.headline)
            .multilineTextAlignment(.leading)
            .lineLimit(3, reservesSpace: true)
            .foregroundStyle(Colors.white)
    }
}
