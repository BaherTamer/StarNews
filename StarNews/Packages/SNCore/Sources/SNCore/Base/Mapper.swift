//
//  Mapper.swift
//  SNCore
//
//  Created by Baher Tamer on 19/06/2025.
//

import Foundation.NSData

open class Mapper<T> {
    public init() {}

    open func parse(_ data: Data) throws -> T {
        fatalError("You must implement this function in the subclass")
    }

    public final func decode<OUTPUT: Decodable>(data: Data) throws -> OUTPUT {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(OUTPUT.self, from: data)
    }
}
