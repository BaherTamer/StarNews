//
//  CacheService.swift
//  SNCache
//
//  Created by Baher Tamer on 19/06/2025.
//

public protocol CacheService: Sendable {
    associatedtype Value

    func getValue(forKey key: String) -> Value?
    func setValue(_ value: Value, forKey key: String)
    func clearCache()
}
