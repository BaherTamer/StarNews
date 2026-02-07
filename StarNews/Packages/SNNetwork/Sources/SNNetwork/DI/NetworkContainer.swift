//
//  NetworkContainer.swift
//  SNNetwork
//
//  Created by Baher Tamer on 07/02/2026.
//

import Factory
import Foundation

public extension Container {
    var networkService: Factory<NetworkService> {
        self {
            RESTNetworkService(
                baseURL: self.baseURL(),
                session: self.networkSession()
            )
        }
        .singleton
    }
}

// MARK: - Private Helpers
extension Container {
    private var baseURL: Factory<String> {
        self {
            NetworkConfig.baseURL
        }
        .singleton
    }
    
    private var networkSession: Factory<NetworkSession> {
        self {
            URLSession.shared
        }
        .singleton
    }
}
