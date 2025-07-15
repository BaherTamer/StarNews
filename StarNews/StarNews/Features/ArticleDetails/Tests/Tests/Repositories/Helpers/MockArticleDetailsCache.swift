//
//  MockArticleDetailsCache.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import SNCache
@testable import ArticleDetails

final class MockArticleDetailsCache: CacheService {
    // MARK: - Variables
    typealias Value = ArticleDetails
    private nonisolated(unsafe) var storage: [String: ArticleDetails] = [:]
    
    func getValue(forKey key: String) -> Value? {
        storage[key]
    }
    
    func setValue(_ value: Value, forKey key: String) {
        storage[key] = value
    }
    
    func clearCache() {
        storage = [:]
    }
}
