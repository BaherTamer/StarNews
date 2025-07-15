//
//  FailureEndpoint.swift
//  SNNetwork
//
//  Created by Baher Tamer on 15/07/2025.
//

import Foundation
@testable import SNNetwork

struct FailureEndpoint: Endpoint {
    var path: String { "invalid path" }
    var method: HTTPMethod { .get }

    func buildURLRequest(with baseURLString: String) throws -> URLRequest {
        throw URLError(.badURL)
    }
}
