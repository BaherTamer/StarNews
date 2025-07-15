//
//  AppLabel.swift
//  Shared
//
//  Created by Baher Tamer on 29/06/2025.
//

import SwiftUI

public struct AppLabel: View {
    // MARK: - Inputs
    private let title: String
    private let image: Image
    
    // MARK: - Life Cycle
    public init(_ title: String, image: Image) {
        self.title = title
        self.image = image
    }
    
    // MARK: - Body
    public var body: some View {
        Label(
            title: {
                titleText
            },
            icon: {
                iconImage
            }
        )
    }
}

// MARK: - Components
extension AppLabel {
    private var titleText: some View {
        Text(verbatim: title)
    }
    
    private var iconImage: some View {
        image
    }
}
