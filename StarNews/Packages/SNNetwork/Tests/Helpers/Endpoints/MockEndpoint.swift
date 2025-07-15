//
//  MockEndpoint.swift
//  SNNetwork
//
//  Created by Baher Tamer on 15/07/2025.
//

@testable import SNNetwork

struct MockEndpoint: Endpoint {
    var path: String { "test" }
    var method: HTTPMethod { .get }
}
