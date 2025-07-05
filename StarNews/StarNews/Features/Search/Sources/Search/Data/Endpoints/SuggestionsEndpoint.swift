//
//  SuggestionsEndpoint.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import SNNetwork

struct SuggestionsEndpoint: Endpoint {
    // MARK: - Inputs
    private let query: String

    // MARK: - Life Cycle
    init(query: String) {
        self.query = query
    }

    // MARK: - Base
    var method: HTTPMethod = .get
    var path: String = "articles/"
    var queryParams: [String: String]? {
        [
            "limit": "10",
            "search": query,
        ]
    }
}
