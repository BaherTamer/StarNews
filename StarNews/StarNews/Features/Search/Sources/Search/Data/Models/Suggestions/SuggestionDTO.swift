//
//  SuggestionDTO.swift
//  Search
//
//  Created by Baher Tamer on 09/02/2026.
//

import SNCore

struct SuggestionDTO: Domainable {
    let id: Int?
    let title: String?
}

// MARK: - Mapping Functions
extension SuggestionDTO {
    func toDomain() -> Suggestion {
        Suggestion(
            id: id ?? -1,
            title: title ?? "N/A"
        )
    }
}
