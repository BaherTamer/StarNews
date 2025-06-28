//
//  UIViewController+Navigation.swift
//  SNCore
//
//  Created by Baher Tamer on 24/06/2025.
//

import UIKit.UIViewController

extension UIViewController {
    public func pushVC(_ viewController: UIViewController) {
        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}
