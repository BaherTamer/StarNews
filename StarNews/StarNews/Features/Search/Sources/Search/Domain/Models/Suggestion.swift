//
//  Suggestion.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

struct Suggestion: Identifiable {
    let id: Int
    let title: String
}

// MARK: - Dummy Data
extension Suggestion {
    public static let dummyList: [Suggestion] = [
        Suggestion(
            id: 28823,
            title: "GITAI expanding satellite product line after successful demo"
        ),
        Suggestion(
            id: 28822,
            title: "COMING SOON: 2024 Annual Highlights of Results from the International Space Station"
        ),
        Suggestion(
            id: 28820,
            title: "Live coverage: SpaceX to launch 21 Starlink satellites on Falcon 9 rocket from Cape Canaveral"
        ),
    ]
}
