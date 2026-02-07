//
//  Factory+Resolver.swift
//  SNCore
//
//  Created by Baher Tamer on 07/02/2026.
//

import Factory
import UIKit.UIViewController

public enum Resolver {
    @inline(__always)
    public static func resolve<T>(
        _ keyPath: KeyPath<Container, Factory<T>>,
        container: Container = Container.shared
    ) -> T {
        container[keyPath: keyPath]()
    }
    
    @inline(__always)
    public static func resolve<A, T>(
        _ keyPath: KeyPath<Container, ParameterFactory<A, T>>,
        _ arg: A,
        container: Container = Container.shared
    ) -> T {
        container[keyPath: keyPath](arg)
    }
}
