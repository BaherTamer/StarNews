//
//  NetworkConfig.swift
//  SNNetwork
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation.NSBundle

public enum NetworkConfig {
    public static let baseURL: String = {
        guard
            let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
            !url.isEmpty
        else {
            fatalError("Missing or invalid BASE_URL in Info.plist. Please set a non-empty string for the BASE_URL key in your target's Info.plist (per configuration).")
        }
        return url
    }()
}
