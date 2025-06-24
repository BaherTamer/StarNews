//
//  RESTNetworkService.swift
//  SNNetwork
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation.NSURL

public struct RESTNetworkService: NetworkService {
    // MARK: - Inputs
    private let session: URLSession

    // MARK: - Life Cycle
    public init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Base Functions
    public func request(with endpoint: Endpoint) async throws -> Data {
        let request = try createURLRequest(from: endpoint)
        let (data, response) = try await fetchData(with: request)
        try validateResponse(response)
        return data
    }
}

// MARK: - Private Helpers
extension RESTNetworkService {
    private func createURLRequest(from endpoint: Endpoint) throws -> URLRequest {
        do {
            return try endpoint.buildURLRequest(with: NetworkConfig.baseURL)
        } catch {
            throw NetworkError.invalidURL
        }
    }

    private func fetchData(with request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch {
            throw NetworkError.invalidData
        }
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard
            let httpResponse = response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode
        else {
            throw NetworkError.invalidResponse
        }
    }
}
