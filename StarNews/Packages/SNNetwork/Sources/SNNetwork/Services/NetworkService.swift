//
//  NetworkService.swift
//  SNNetwork
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation

public protocol NetworkService: Sendable {
    func request(with endpoint: Endpoint) async throws -> Data
}
