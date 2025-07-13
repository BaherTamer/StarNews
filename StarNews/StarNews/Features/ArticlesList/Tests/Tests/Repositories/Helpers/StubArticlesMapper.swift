//
//  StubArticlesMapper.swift
//  ArticlesList
//
//  Created by Baher Tamer on 13/07/2025.
//

import Foundation.NSData
import Shared
@testable import ArticlesList

protocol TestableArticlesMapper: ArticlesMapper {
    var shouldThrowError: Bool { get set }
}

final class StubArticlesMapper: TestableArticlesMapper {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Core Functions
    func parse(_ data: Data) throws -> PaginatedData<Article> {
        if shouldThrowError {
            throw ArticlesError.mapperError
        }
        
        return PaginatedData(
            items: Article.dummyList,
            pageInfo: .initial
        )
    }
}
