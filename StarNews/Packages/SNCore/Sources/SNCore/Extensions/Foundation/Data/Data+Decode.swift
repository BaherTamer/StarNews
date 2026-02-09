//
//  Data+Decode.swift
//  SNCore
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation.NSData

extension Data {
    public func decode<T: Decodable>(_ type: T.Type) throws -> T {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(T.self, from: self)
    }
}
