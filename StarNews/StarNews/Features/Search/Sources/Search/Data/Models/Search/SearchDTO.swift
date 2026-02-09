//
//  SearchDTO.swift
//  Search
//
//  Created by Baher Tamer on 09/02/2026.
//

import Shared
import SNCore

struct SearchDTO: Domainable {
    let count: Int?
    let next: String?
    let results: [SearchResultDTO]?
}

// MARK: - Mapping Functions
extension SearchDTO {
    func toDomain() -> PaginatedData<SearchResult> {
        let searchResults = results.toDomain()
        let pageInfo = PageInfo.toDomain(next: next, count: count)
        let data = PaginatedData(items: searchResults, pageInfo: pageInfo)
        return data
    }
}
