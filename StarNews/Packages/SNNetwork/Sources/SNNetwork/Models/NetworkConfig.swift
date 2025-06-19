//
//  NetworkConfig.swift
//  SNNetwork
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation

enum NetworkConfig {
    static let baseURL = Bundle.main.object(
        forInfoDictionaryKey: "BASE_URL"
    ) as? String ?? ""
}
