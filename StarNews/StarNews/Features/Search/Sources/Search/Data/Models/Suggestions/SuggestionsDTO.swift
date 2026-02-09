//
//  SuggestionsDTO.swift
//  Search
//
//  Created by Baher Tamer on 09/02/2026.
//

struct SuggestionsDTO: Decodable {
    let results: [SuggestionDTO]?
}

// MARK: - Mapping Functions
extension SuggestionsDTO {
    func toDomain() -> [Suggestion] {
        results.toDomain()
    }
}
