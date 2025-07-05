//
//  SearchMapper.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import Shared
import SNCore
import Foundation.NSData

final class SearchMapper: Mapper<PaginatedData<SearchResult>> {
    // MARK: - Base Functions
    override func parse(_ data: Data) throws -> PaginatedData<SearchResult> {
        let response: DataResponse = try decode(data: data)
        let searchResults = mapResponse(response)
        return searchResults
    }
}

// MARK: - Mapping Functions
extension SearchMapper {
    private func mapResponse(_ response: DataResponse) -> PaginatedData<SearchResult> {
        let searchResults = response.results?.compactMap(mapSearch) ?? []
        let pageInfo = mapPageInfo(response)
        let data = PaginatedData(items: searchResults, pageInfo: pageInfo)
        return data
    }

    private func mapPageInfo(_ response: DataResponse) -> PageInfo {
        let info = extractLimitAndOffset(from: response.next)
        let currentPage = (info?.offset ?? 1) / (info?.limit ?? 1)
        let pageSize = info?.limit ?? 10
        let pageInfo = PageInfo(
            currentPage: currentPage,
            pageSize: pageSize,
            itemsCount: response.count ?? 0
        )
        return pageInfo
    }

    private func mapSearch(_ search: SearchModel) -> SearchResult {
        let date = parseISO8601Date(from: search.publishedAt)
        let searchResult = SearchResult(
            id: search.id ?? -1,
            title: search.title ?? "N/A",
            imageURL: search.imageUrl ?? "",
            publishDate: date ?? .now
        )
        return searchResult
    }
    
    private func parseISO8601Date(from string: String?) -> Date? {
        guard let string else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: string)
    }
}

// MARK: - Models
extension SearchMapper {
    fileprivate struct DataResponse: Decodable {
        let count: Int?
        let next: String?
        let results: [SearchModel]?
    }

    fileprivate struct SearchModel: Decodable {
        let id: Int?
        let title: String?
        let imageUrl: String?
        let publishedAt: String?
    }
}
