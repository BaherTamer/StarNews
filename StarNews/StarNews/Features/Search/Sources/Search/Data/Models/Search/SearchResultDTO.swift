//
//  SearchResultDTO.swift
//  Search
//
//  Created by Baher Tamer on 09/02/2026.
//

struct SearchResultDTO: Decodable {
    let id: Int?
    let title: String?
    let imageUrl: String?
    let publishedAt: String?
}

// MARK: - Mapping Functions
extension SearchResultDTO {
    func toDomain() -> SearchResult {
        let date = publishedAt.parseISO8601Date()
        let searchResult = SearchResult(
            id: id ?? -1,
            title: title ?? "N/A",
            imageURL: imageUrl ?? "",
            publishDate: date ?? .now
        )
        return searchResult
    }
}

extension [SearchResultDTO]? {
    func toDomain() -> [SearchResult] {
        self?.compactMap {
            $0.toDomain()
        } ?? []
    }
}
