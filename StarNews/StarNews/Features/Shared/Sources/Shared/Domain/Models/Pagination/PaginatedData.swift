//
//  PaginatedData.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

public struct PaginatedData<PageItem> {
    public let items: [PageItem]
    public let pageInfo: PageInfo

    public init(items: [PageItem], pageInfo: PageInfo) {
        self.items = items
        self.pageInfo = pageInfo
    }
}
