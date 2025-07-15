//
//  MemoryCacheServiceTests.swift
//  SNCache
//
//  Created by Baher Tamer on 15/07/2025.
//

import Testing
@testable import SNCache

struct MemoryCacheServiceTests {
    // MARK: - Variables
    private let memoryCache: MemoryCacheService<String>!
    
    // MARK: - Life Cycle
    init() {
        self.memoryCache = MemoryCacheService()
    }
    
    // MARK: - Tests Functions
    
    @Test private func validValue() {
        // Given
        let key = "key"
        let value = "StartNews"
        
        // When
        memoryCache.setValue(value, forKey: key)
        let cachedValue = memoryCache.getValue(forKey: key)
        
        // Then
        #expect(value == cachedValue)
    }
    
    @Test private func nullableValue() {
        // Given
        let key = "key"
        
        // When
        let cachedValue = memoryCache.getValue(forKey: key)
        
        // Then
        #expect(cachedValue == nil)
    }
    
    @Test private func valueOverwrite() {
        // Given
        let key = "key"
        let firstValue = "first"
        let secondValue = "second"

        // When
        memoryCache.setValue(firstValue, forKey: key)
        memoryCache.setValue(secondValue, forKey: key)
        let cachedValue = memoryCache.getValue(forKey: key)

        // Then
        #expect(cachedValue == secondValue)
    }
    
    @Test private func clearCache() {
        // Given
        let key1 = "key1"
        let key2 = "key1"
        memoryCache.setValue("Value 1", forKey: key1)
        memoryCache.setValue("Value 2", forKey: key2)

        // When
        memoryCache.clearCache()
        let value1 = memoryCache.getValue(forKey: key1)
        let value2 = memoryCache.getValue(forKey: key2)

        // Then
        #expect(value1 == nil)
        #expect(value2 == nil)
    }
}
