//
//  UIViewController+HostingController.swift
//  SNCore
//
//  Created by Baher Tamer on 19/06/2025.
//

import SwiftUI

extension UIViewController {
    public static func createHC<Content: View>(
        with rootView: Content
    ) -> UIViewController {
        let hostingController = UIHostingController(rootView: rootView)
        hostingController.view.backgroundColor = .clear
        return hostingController
    }
}
