//
//  ArticleDetails.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Foundation.NSDate

struct ArticleDetails: Identifiable {
    let id: Int
    let title: String
    let authors: [String]
    let url: String
    let imageURL: String
    let siteName: String
    let summary: String
    let publishDate: Date
}

// MARK: - Dummy Data
extension ArticleDetails {
    static let example = ArticleDetails(
        id: 30987,
        title: "Lockheed Martin delivers completed Orion to NASA for Artemis 2",
        authors: ["Jeff Foust"],
        url: "https://spacenews.com/lockheed-martin-delivers-completed-orion-to-nasa-for-artemis-2/",
        imageURL: "https://i0.wp.com/spacenews.com/wp-content/uploads/2025/05/orion-art2-handover.jpeg?fit=1024%2C683&quality=89&ssl=1",
        siteName: "SpaceNews",
        summary: "\nLockheed Martin formally delivered to NASA May 1 the Orion spacecraft for Artemis 2, keeping that mission on track for a launch in early 2026.\nThe post Lockheed Martin delivers completed Orion to NASA for Artemis 2 appeared first on SpaceNews.",
        publishDate: .now
    )
}
