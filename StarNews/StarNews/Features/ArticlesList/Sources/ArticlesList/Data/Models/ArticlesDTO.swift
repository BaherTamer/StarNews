//
//  ArticlesDTO.swift
//  ArticlesList
//
//  Created by Baher Tamer on 09/02/2026.
//

import Shared
import SNCore

struct ArticlesDTO: Domainable {
    let count: Int?
    let next: String?
    let results: [ArticleDTO]?
}

// MARK: - Mapping Functions
extension ArticlesDTO {
    func toDomain() -> PaginatedData<Article> {
        let articles = results.toDomain()
        let pageInfo = PageInfo.toDomain(next: next, count: count)
        let data = PaginatedData(items: articles, pageInfo: pageInfo)
        return data
    }
}
