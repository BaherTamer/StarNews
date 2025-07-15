//
//  StubSuggestionsNetworkService.swift
//  Search
//
//  Created by Baher Tamer on 14/07/2025.
//

import Foundation
import SNNetwork
@testable import Search

protocol TestableSuggestionsNetworkService: NetworkService {
    var shouldThrowError: Bool { get set }
}

final class StubSuggestionsNetworkService: TestableSuggestionsNetworkService {
    // MARK: - Variables
    nonisolated(unsafe) var shouldThrowError = false
    
    // MARK: - Base Functions
    func request(with endpoint: Endpoint) async throws -> Data {
        if shouldThrowError {
            throw SuggestionsError.networkError
        }
        
        return MockSuggestionsJSON.validData.data(using: .utf8)!
    }
}
