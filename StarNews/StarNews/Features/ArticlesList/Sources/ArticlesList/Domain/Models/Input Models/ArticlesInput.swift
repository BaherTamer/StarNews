//
//  ArticlesInput.swift
//  ArticlesList
//
//  Created by Baher Tamer on 05/07/2025.
//

struct ArticlesInput {
    let page: Int
    let limit: Int
}

// MARK: - Private Helpers
extension ArticlesInput {
    var offset: String {
        ((page - 1) * limit).description
    }
}
