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
    private let mapper: SuggestionsMapper

    // MARK: - Life Cycle
    init(
        networkService: NetworkService,
        mapper: SuggestionsMapper
    ) {
        self.networkService = networkService
        self.mapper = mapper
    }
}

// MARK: - Base Functions
extension DefaultSuggestionsRepository {
    func getSuggestions(query: String) async throws -> [Suggestion] {
        let endpoint = SuggestionsEndpoint(query: query)
        let response = try await networkService.request(with: endpoint)
        let suggestions = try mapper.parse(response)
        return suggestions
    }
}
