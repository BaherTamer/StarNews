//
//  RESTNetworkServiceTests.swift
//  SNNetwork
//
//  Created by Baher Tamer on 15/07/2025.
//

import Foundation
import Testing
@testable import SNNetwork

final class RESTNetworkServiceTests {
    // MARK: - Variables
    private let url: URL
    private let endpoint: MockEndpoint
    private let session: StubNetworkSession
    private var networkService: NetworkService!
    
    // MARK: - Life Cycle
    init() {
        self.url = URL(string: "https://example.com/test")!
        self.endpoint = MockEndpoint()
        self.session = StubNetworkSession()
        self.networkService = RESTNetworkService(
            baseURL: "example.com",
            session: session
        )
    }
    
    // MARK: - Test Functions
    
    @Test private func successRequest() async throws {
        // Give
        let expectedData = "Success".data(using: .utf8)!
        session.data = expectedData
        session.urlResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let result = try await networkService.request(with: endpoint)
        
        // Then
        #expect(result == expectedData)
    }
    
    @Test private func invalidResponse() async throws {
        // Give
        session.data = Data()
        session.urlResponse = HTTPURLResponse(
            url: url,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        
        // Then
        await #expect(throws: NetworkError.invalidResponse) {
            _ = try await networkService.request(with: endpoint)
        }
    }
    
    @Test private func invalidData() async throws {
        // Give
        session.error = URLError(.notConnectedToInternet)
        
        // Then
        await #expect(throws: NetworkError.invalidData) {
            _ = try await networkService.request(with: endpoint)
        }
    }
    
    @Test private func invalidURL() async throws {
        // Give
        networkService = RESTNetworkService(
            baseURL: "",
            session: session
        )
        
        // Then
        await #expect(throws: NetworkError.invalidURL) {
            _ = try await networkService.request(with: endpoint)
        }
    }
}
