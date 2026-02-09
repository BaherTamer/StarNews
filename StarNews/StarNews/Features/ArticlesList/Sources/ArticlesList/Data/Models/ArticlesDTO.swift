//
//  ArticlesDTO.swift
//  ArticlesList
//
//  Created by Baher Tamer on 09/02/2026.
//

import Shared

struct ArticlesDTO: PaginatedDomainable {
    let count: Int?
    let next: String?
    let results: [ArticleDTO]?
}

// MARK: - Mapping Functions
extension ArticlesDTO {
    func toDomain() -> PaginatedData<Article> {
        let articles = results.toDomain()
        let pageInfo = toPageInfo()
        let data = PaginatedData(items: articles, pageInfo: pageInfo)
        return data
    }
}
