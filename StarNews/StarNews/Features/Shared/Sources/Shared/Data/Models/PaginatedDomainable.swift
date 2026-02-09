//
//  PaginatedDomainable.swift
//  Shared
//
//  Created by Baher Tamer on 09/02/2026.
//

import Foundation
import SNCore

public protocol PaginatedDomainable: Domainable {
    var next: String? { get }
    var count: Int? { get }
}

// MARK: - Mapping Functions
public extension PaginatedDomainable {
    func toPageInfo() -> PageInfo {
        let info = extractLimitAndOffset()
        let currentPage = (info?.offset ?? 1) / (info?.limit ?? 1)
        let pageSize = info?.limit ?? 10
        let pageInfo = PageInfo(
            currentPage: currentPage,
            pageSize: pageSize,
            itemsCount: count ?? 0
        )
        return pageInfo
    }
}

// MARK: - Private Helpers
extension PaginatedDomainable {
    private func extractLimitAndOffset() -> (limit: Int?, offset: Int?)? {
        guard
            let next,
            let components = URLComponents(string: next),
            let queryItems = components.queryItems
        else { return nil }
        let limit = extractIntQueryItem(named: "limit", from: queryItems)
        let offset = extractIntQueryItem(named: "offset", from: queryItems)
        return (limit, offset)
    }
    
    private func extractIntQueryItem(
        named name: String,
        from queryItems: [URLQueryItem]
    ) -> Int? {
        queryItems
            .first(where: { $0.name == name })
            .flatMap { $0.value }
            .flatMap(Int.init)
    }
}
