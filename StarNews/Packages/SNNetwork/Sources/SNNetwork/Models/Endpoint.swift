//
//  Endpoint.swift
//  SNNetwork
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
    var queryParams: [String: String]? { get }
}

// MARK: - Config Variables
extension Endpoint {
    public var headers: [String: String]? { nil }
    public var body: [String: Any]? { nil }
    public var queryParams: [String: String]? { nil }
}

// MARK: - Core Functions
extension Endpoint {
    func buildURLRequest(with baseURLString: String) throws -> URLRequest {
        let requestURL = createRequestURL(with: baseURLString)
        var request = createBaseRequest(with: requestURL)
        setRequestMethod(&request)
        setRequestHeaders(&request)
        try setRequestBody(&request)
        setRequestQueryParams(&request, requestURL: requestURL)
        return request
    }
}

// MARK: - Private Helpers
extension Endpoint {
    private func createRequestURL(with urlString: String) -> URL {
        guard
            let baseURL = URL(string: "https://" + urlString)
        else {
            fatalError("Base URL is not valid.")
        }
        let requestURL = baseURL.appendingPathComponent(path)
        return requestURL
    }
    
    private func createBaseRequest(with requestURL: URL) -> URLRequest {
        URLRequest(url: requestURL)
    }

    private func setRequestMethod(_ request: inout URLRequest) {
        request.httpMethod = method.rawValue
    }

    private func setRequestHeaders(_ request: inout URLRequest) {
        request.allHTTPHeaderFields = headers
    }

    private func setRequestBody(_ request: inout URLRequest) throws {
        guard let body else { return }
        request.httpBody = try JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
    }

    private func setRequestQueryParams(_ request: inout URLRequest, requestURL: URL) {
        guard let queryParams else { return }
        var components = URLComponents(
            url: requestURL,
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = mapQueryItems(from: queryParams)
        if let urlWithParams = components?.url {
            request.url = urlWithParams
        }
    }

    private func mapQueryItems(from queryParams: [String: String]) -> [URLQueryItem] {
        queryParams.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
    }
}
