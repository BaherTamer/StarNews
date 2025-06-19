//
//  View+ShareSheet.swift
//  SNCore
//
//  Created by Baher Tamer on 19/06/2025.
//

import SwiftUI

extension View {
    public func presentShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        windowScene.keyWindow?.rootViewController?.present(
            activityViewController,
            animated: true
        )
    }
}
