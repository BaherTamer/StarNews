//
//  SearchDTO.swift
//  Search
//
//  Created by Baher Tamer on 09/02/2026.
//

import Shared

struct SearchDTO: PaginatedDomainable {
    let count: Int?
    let next: String?
    let results: [SearchResultDTO]?
}

// MARK: - Mapping Functions
extension SearchDTO {
    func toDomain() -> PaginatedData<SearchResult> {
        let searchResults = results.toDomain()
        let pageInfo = toPageInfo()
        let data = PaginatedData(items: searchResults, pageInfo: pageInfo)
        return data
    }
}
