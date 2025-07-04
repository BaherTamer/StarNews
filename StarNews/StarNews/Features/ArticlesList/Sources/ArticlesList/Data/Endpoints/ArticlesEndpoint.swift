//
//  ArticlesEndpoint.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import SNNetwork

struct ArticlesEndpoint: Endpoint {
    // MARK: - Inputs
    private let input: ArticlesInput

    // MARK: - Life Cycle
    init(input: ArticlesInput) {
        self.input = input
    }

    // MARK: - Base
    var method: HTTPMethod = .get
    var path: String = "articles/"
    var queryParams: [String: String]? {
        [
            "limit": input.limit.description,
            "offset": offset,
        ]
    }
}

// MARK: - Private Helpers
extension ArticlesEndpoint {
    private var offset: String {
        ((input.page - 1) * input.limit).description
    }
}
