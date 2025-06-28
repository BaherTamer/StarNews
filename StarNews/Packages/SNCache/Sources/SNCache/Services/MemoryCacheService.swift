//
//  MemoryCacheService.swift
//  SNCache
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation.NSCache

public final class MemoryCacheService<Value>: CacheService {
    // MARK: - Constants
    nonisolated(unsafe) private let cache = NSCache<WrappedKey, Entry<Value>>()
    
    // MARK: - Life Cycle
    public init() {}
}

// MARK: - Base Functions
extension MemoryCacheService {
    public func getValue(forKey key: String) -> Value? {
        let wrappedKey = WrappedKey(key)
        return cache.object(forKey: wrappedKey)?.value
    }
    
    public func setValue(_ value: Value, forKey key: String) {
        let wrappedKey = WrappedKey(key)
        let entry = Entry(value: value)
        cache.setObject(entry, forKey: wrappedKey)
    }
    
    public func clearCache() {
        cache.removeAllObjects()
    }
}
