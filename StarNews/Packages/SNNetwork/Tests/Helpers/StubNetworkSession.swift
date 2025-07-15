//
//  StubNetworkSession.swift
//  SNNetwork
//
//  Created by Baher Tamer on 15/07/2025.
//

import Foundation
@testable import SNNetwork

final class StubNetworkSession: NetworkSession {
    // MARK: - Variables
    nonisolated(unsafe) var data: Data?
    nonisolated(unsafe) var urlResponse: URLResponse?
    nonisolated(unsafe) var error: Error?

    // MARK: - Base Functions
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        return (data ?? Data(), urlResponse ?? URLResponse())
    }
}
