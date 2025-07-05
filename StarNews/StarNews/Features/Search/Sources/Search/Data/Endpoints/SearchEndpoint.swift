//
//  SearchEndpoint.swift
//  Search
//
//  Created by Baher Tamer on 04/07/2025.
//

import SNNetwork

struct SearchEndpoint: Endpoint {
    // MARK: - Inputs
    private let input: SearchInput

    // MARK: - Life Cycle
    init(input: SearchInput) {
        self.input = input
    }

    // MARK: - Base
    var method: HTTPMethod = .get
    var path: String = "articles/"
    var queryParams: [String: String]? {
        [
            "limit": input.limit.description,
            "offset": input.offset,
            "search": input.query,
        ]
    }
}
