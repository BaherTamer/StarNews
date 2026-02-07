//
//  StubArticleDetailsMapper.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Foundation.NSData
@testable import ArticleDetails

protocol TestableArticleDetailsMapper: ArticleDetailsMapper {
    var shouldThrowError: Bool { get set }
}

struct StubArticleDetailsMapper: TestableArticleDetailsMapper {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Core Functions
    func parse(_ data: Data) throws -> ArticleDetails {
        if shouldThrowError {
            throw ArticleDetailsError.mapperError
        }
        
        return ArticleDetails.example
    }
}
