//
//  SearchResult.swift
//  Search
//
//  Created by Baher Tamer on 04/07/2025.
//

import Foundation.NSDate

struct SearchResult: Identifiable {
    let id: Int
    let title: String
    let imageURL: String
    let publishDate: Date
}

// MARK: - Dummy Data
extension SearchResult {
    public static let dummyList: [SearchResult] = [
        SearchResult(
            id: 28823,
            title: "GITAI expanding satellite product line after successful demo",
            imageURL: "https://i0.wp.com/spacenews.com/wp-content/uploads/2025/01/05_Assembly-scaled.jpg?fit=1024%2C576&quality=89&ssl=1",
            publishDate: .now
        ),
        SearchResult(
            id: 28822,
            title: "COMING SOON: 2024 Annual Highlights of Results from the International Space Station",
            imageURL: "https://www.nasa.gov/wp-content/uploads/2025/01/websummaryimage-jsc2024e041215.jpg",
            publishDate: .now
        ),
        SearchResult(
            id: 28820,
            title: "Live coverage: SpaceX to launch 21 Starlink satellites on Falcon 9 rocket from Cape Canaveral",
            imageURL: "http://spaceflightnow.com/wp-content/uploads/2024/10/20241022_Starlink_6-61_prelaunch_AB-1.jpg",
            publishDate: .now
        ),
    ]
}

