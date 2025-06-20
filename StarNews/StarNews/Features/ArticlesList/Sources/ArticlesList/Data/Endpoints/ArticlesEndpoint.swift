//
//  ArticlesEndpoint.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import SNNetwork

struct ArticlesEndpoint: Endpoint {
    // MARK: - Inputs
    private let page: Int
    private let limit: Int

    // MARK: - Life Cycle
    init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }

    // MARK: - Base
    var method: HTTPMethod = .get
    var path: String = "articles/"
    var queryParams: [String: String]? {
        [
            "limit": limit.description,
            "offset": offset,
        ]
    }
}

// MARK: - Private Helpers
extension ArticlesEndpoint {
    private var offset: String {
        ((page - 1) * limit).description
    }
}
