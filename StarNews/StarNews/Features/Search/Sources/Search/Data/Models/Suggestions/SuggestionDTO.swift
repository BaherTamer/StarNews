//
//  SuggestionDTO.swift
//  Search
//
//  Created by Baher Tamer on 09/02/2026.
//

struct SuggestionDTO: Decodable {
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

extension [SuggestionDTO]? {
    func toDomain() -> [Suggestion] {
        self?.compactMap {
            $0.toDomain()
        } ?? []
    }
}
