//
//  MockSearchCache.swift
//  Search
//
//  Created by Baher Tamer on 13/07/2025.
//

import SNCache
import Shared
@testable import Search

final class MockSearchCache: CacheService {
    // MARK: - Variables
    typealias Value = PaginatedData<SearchResult>
    private nonisolated(unsafe) var storage: [String: Value] = [:]
    
    // MARK: - Core Functions
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
