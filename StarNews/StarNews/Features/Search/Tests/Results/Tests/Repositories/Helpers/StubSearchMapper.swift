//
//  StubSearchMapper.swift
//  Search
//
//  Created by Baher Tamer on 13/07/2025.
//

import Foundation.NSData
import Shared
@testable import Search

protocol TestableSearchMapper: SearchMapper {
    var shouldThrowError: Bool { get set }
}

struct StubSearchMapper: TestableSearchMapper {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Core Functions
    func parse(_ data: Data) throws -> PaginatedData<SearchResult> {
        if shouldThrowError {
            throw SearchError.mapperError
        }
        
        return PaginatedData(
            items: SearchResult.dummyList,
            pageInfo: .initial
        )
    }
}
