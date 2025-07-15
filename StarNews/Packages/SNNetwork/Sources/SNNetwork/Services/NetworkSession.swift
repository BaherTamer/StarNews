//
//  NetworkSession.swift
//  SNNetwork
//
//  Created by Baher Tamer on 15/07/2025.
//

import Foundation

public protocol NetworkSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
