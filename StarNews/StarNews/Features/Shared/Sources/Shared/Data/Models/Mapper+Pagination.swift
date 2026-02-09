//
//  PageInfo+Parsing.swift
//  Shared
//
//  Created by Baher Tamer on 05/07/2025.
//

import Foundation

extension PageInfo {
    public static func toDomain(next: String?, count: Int?) -> PageInfo {
        let info = extractLimitAndOffset(from: next)
        let currentPage = (info?.offset ?? 1) / (info?.limit ?? 1)
        let pageSize = info?.limit ?? 10
        let pageInfo = PageInfo(
            currentPage: currentPage,
            pageSize: pageSize,
            itemsCount: count ?? 0
        )
        return pageInfo
    }
    
    public static func extractLimitAndOffset(from url: String?) -> (limit: Int?, offset: Int?)? {
        guard
            let url,
            let components = URLComponents(string: url),
            let queryItems = components.queryItems
        else { return nil }
        let limit = extractIntQueryItem(named: "limit", from: queryItems)
        let offset = extractIntQueryItem(named: "offset", from: queryItems)
        return (limit, offset)
    }
    
    private static func extractIntQueryItem(
        named name: String,
        from queryItems: [URLQueryItem]
    ) -> Int? {
        queryItems
            .first(where: { $0.name == name })
            .flatMap { $0.value }
            .flatMap(Int.init)
    }
}
