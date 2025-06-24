//
//  ArticleDetailsEndpoint.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import SNNetwork

struct ArticleDetailsEndpoint: Endpoint {
    // MARK: - Inputs
    private let id: Int

    // MARK: - Life Cycle
    init(id: Int) {
        self.id = id
    }

    // MARK: - Base
    var method: HTTPMethod = .get
    var path: String {
        "articles/\(id.description)"
    }
}
