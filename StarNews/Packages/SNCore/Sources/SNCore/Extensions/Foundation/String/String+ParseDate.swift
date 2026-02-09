//
//  String+ParseDate.swift
//  SNCore
//
//  Created by Baher Tamer on 09/02/2026.
//

import Foundation

public extension String? {
    func parseISO8601Date() -> Date? {
        guard let self else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: self)
    }
}
