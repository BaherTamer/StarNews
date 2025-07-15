//
//  Mapper.swift
//  SNCore
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation.NSData

public protocol Mapper: Sendable {
    associatedtype Output
    func parse(_ data: Data) throws -> Output
}

extension Mapper {
    public func decode<OUTPUT: Decodable>(data: Data) throws -> OUTPUT {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(OUTPUT.self, from: data)
    }
}
