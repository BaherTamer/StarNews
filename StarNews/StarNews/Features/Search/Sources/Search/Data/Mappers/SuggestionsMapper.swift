//
//  SuggestionsMapper.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import SNCore
import Foundation.NSData

final class SuggestionsMapper: Mapper<[Suggestion]> {
    // MARK: - Base Functions
    override func parse(_ data: Data) throws -> [Suggestion] {
        let response: DataResponse = try decode(data: data)
        let suggestions = mapResponse(response)
        return suggestions
    }
}

// MARK: - Mapping Functions
extension SuggestionsMapper {
    private func mapResponse(_ response: DataResponse) -> [Suggestion] {
        let suggestions = response.results?.compactMap(mapSuggestion)
        return suggestions ?? []
    }

    private func mapSuggestion(_ suggestion: SuggestionModel) -> Suggestion {
        Suggestion(
            id: suggestion.id ?? -1,
            title: suggestion.title ?? "N/A"
        )
    }
}

// MARK: - Models
extension SuggestionsMapper {
    fileprivate struct DataResponse: Decodable {
        let results: [SuggestionModel]?
    }

    fileprivate struct SuggestionModel: Decodable {
        let id: Int?
        let title: String?
    }
}
