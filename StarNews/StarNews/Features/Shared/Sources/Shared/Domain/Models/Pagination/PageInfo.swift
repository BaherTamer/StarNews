//
//  PageInfo.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

public struct PageInfo {
    public let currentPage: Int
    public let pageSize: Int
    public let itemsCount: Int

    public init(currentPage: Int, pageSize: Int, itemsCount: Int) {
        self.currentPage = currentPage
        self.pageSize = pageSize
        self.itemsCount = itemsCount
    }
}

extension PageInfo {
    nonisolated(unsafe) public static let initial = PageInfo(
        currentPage: 0,
        pageSize: 10,
        itemsCount: 0
    )
}

extension PageInfo {
    public var shouldPaginateForward: Bool {
        nextPage < totalPages
    }

    public var shouldPaginateBackward: Bool {
        currentPage > 1
    }

    public var nextPage: Int {
        currentPage + 1
    }

    public var previousPage: Int {
        currentPage - 1
    }

    public var totalPages: Int {
        Int(itemsCount / pageSize)
    }
}
