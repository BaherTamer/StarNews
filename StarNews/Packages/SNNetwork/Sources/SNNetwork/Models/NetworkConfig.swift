//
//  NetworkConfig.swift
//  SNNetwork
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation.NSBundle

public enum NetworkConfig {
    public static let baseURL = Bundle.main.object(
        forInfoDictionaryKey: "BASE_URL"
    ) as? String ?? ""
}
