//
//  WrappedKey.swift
//  SNCache
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation

final class WrappedKey: NSObject {
    // MARK: - Inputs
    let key: String

    // MARK: - Life Cycle
    init(_ key: String) {
        self.key = key
    }

    // MARK: - Base
    override var hash: Int {
        key.hashValue
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard
            let other = object as? WrappedKey
        else { return false }
        return key == other.key
    }
}
