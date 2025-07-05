//
//  WebImage.swift
//  SharedUI
//
//  Created by Baher Tamer on 19/06/2025.
//

import Kingfisher
import SNDesignSystem
import SwiftUI

public struct WebImage: View {
    // MARK: - Inputs
    private let urlString: String?
    private let contentMode: SwiftUI.ContentMode
    
    // MARK: - Computed Properties
    private var imageURL: URL? {
        URL(string: urlString ?? "")
    }
    
    // MARK: - Life Cycle
    public init(
        urlString: String?,
        contentMode: SwiftUI.ContentMode
    ) {
        self.urlString = urlString
        self.contentMode = contentMode
    }
    
    // MARK: - Body
    public var body: some View {
        KFImage(imageURL)
            .placeholder(progressView)
            .retry(maxCount: 3, interval: .seconds(5))
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

// MARK: - Components
extension WebImage {
    private func progressView() -> some View {
        ProgressView()
            .imageScale(.large)
            .tint(Colors.white)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Colors.gray)
    }
}
