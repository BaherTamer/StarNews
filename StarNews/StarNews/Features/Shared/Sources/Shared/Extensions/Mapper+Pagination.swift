//
//  Mapper+Pagination.swift
//  Shared
//
//  Created by Baher Tamer on 05/07/2025.
//

import Foundation
import SNCore

extension Mapper {
    public func extractLimitAndOffset(from url: String?) -> (limit: Int?, offset: Int?)? {
        guard
            let url,
            let components = URLComponents(string: url),
            let queryItems = components.queryItems
        else { return nil }
        let limit = extractIntQueryItem(named: "limit", from: queryItems)
        let offset = extractIntQueryItem(named: "offset", from: queryItems)
        return (limit, offset)
    }
    
    public func extractIntQueryItem(
        named name: String,
        from queryItems: [URLQueryItem]
    ) -> Int? {
        queryItems
            .first(where: { $0.name == name })
            .flatMap { $0.value }
            .flatMap(Int.init)
    }
}
