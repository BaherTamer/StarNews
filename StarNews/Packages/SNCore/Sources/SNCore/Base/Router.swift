//
//  File.swift
//  SNCore
//
//  Created by Baher Tamer on 07/02/2026.
//

import UIKit.UIViewController

@MainActor
public protocol Router {
    var screenVC: UIViewController? { get set }
}

// MARK: - Navigation Helpers
public extension Router {
    func pushVC(_ viewController: UIViewController) {
        screenVC?.pushVC(viewController)
    }
    
    func presentVC(_ viewController: UIViewController) {
        screenVC?.present(viewController, animated: true)
    }
}
