//
//  StubNetworkService.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

import Foundation.NSData
import SNNetwork
@testable import ArticleDetails

protocol TestableNetworkService: NetworkService {
    var shouldThrowError: Bool { get set }
}

final class StubNetworkService: TestableNetworkService {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func request(with endpoint: Endpoint) async throws -> Data {
        if shouldThrowError {
            throw ArticleDetailsError.networkError
        }
        
        return MockArticleDetailsJSON.validData.data(using: .utf8)!
    }
}
