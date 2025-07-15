//
//  MockEndpoint.swift
//  SNNetwork
//
//  Created by Baher Tamer on 15/07/2025.
//

@testable import SNNetwork

struct MockEndpoint: Endpoint {
    let path = "test"
    let method = HTTPMethod.get
}
