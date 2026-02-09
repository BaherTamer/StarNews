//
//  SuggestionsRepository.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import SNNetwork

protocol SuggestionsRepository: Sendable {
    func getSuggestions(query: String) async throws -> [Suggestion]
}

final class DefaultSuggestionsRepository: SuggestionsRepository {
    // MARK: - Inputs
    private let networkService: NetworkService

    // MARK: - Life Cycle
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

// MARK: - Base Functions
extension DefaultSuggestionsRepository {
    func getSuggestions(query: String) async throws -> [Suggestion] {
        let endpoint = SuggestionsEndpoint(query: query)
        let data = try await networkService.request(with: endpoint)
        let response = try data.decode(SuggestionsDTO.self)
        let suggestions = response.toDomain()
        return suggestions
    }
}
