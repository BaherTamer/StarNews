//
//  Domainable.swift
//  SNCore
//
//  Created by Baher Tamer on 09/02/2026.
//

public protocol Domainable: Decodable {
    associatedtype Domain
    func toDomain() -> Domain
}

extension Optional where Wrapped: Collection, Wrapped.Element: Domainable {
    public func toDomain() -> [Wrapped.Element.Domain] {
        self?.compactMap {
            $0.toDomain()
        } ?? []
    }
}
