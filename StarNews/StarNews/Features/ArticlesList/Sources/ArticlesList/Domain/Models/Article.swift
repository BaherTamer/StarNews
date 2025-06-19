//
//  Article.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

public struct Article {
    let id: Int
    let title: String
    let url: String
    let imageURL: String
    let siteName: String
}

// MARK: - Dummy Data
extension Article {
    nonisolated(unsafe) public static let dummyList: [Article] = [
        Article(
            id: 28823,
            title: "GITAI expanding satellite product line after successful demo",
            url: "https://spacenews.com/gitai-expanding-satellite-product-line-after-successful-demo/",
            imageURL: "https://i0.wp.com/spacenews.com/wp-content/uploads/2025/01/05_Assembly-scaled.jpg?fit=1024%2C576&quality=89&ssl=1",
            siteName: "SpaceNews"
        ),
        Article(
            id: 28822,
            title: "COMING SOON: 2024 Annual Highlights of Results from the International Space Station",
            url: "https://www.nasa.gov/general/coming-soon-2024-annual-highlights-of-results-from-the-international-space-station/",
            imageURL: "https://www.nasa.gov/wp-content/uploads/2025/01/websummaryimage-jsc2024e041215.jpg",
            siteName: "NASA"
        ),
        Article(
            id: 28820,
            title: "Live coverage: SpaceX to launch 21 Starlink satellites on Falcon 9 rocket from Cape Canaveral",
            url: "https://spaceflightnow.com/2025/01/27/live-coverage-spacex-to-launch-21-starlink-satellites-on-falcon-9-rocket-from-cape-canaveral-7/",
            imageURL: "http://spaceflightnow.com/wp-content/uploads/2024/10/20241022_Starlink_6-61_prelaunch_AB-1.jpg",
            siteName: "Spaceflight Now"
        ),
    ]
}
