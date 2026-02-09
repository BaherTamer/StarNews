//
//  AuthorDTO.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 09/02/2026.
//

import SNCore

struct AuthorDTO: Domainable {
    let name: String?
}

// MARK: - Mapping Functions
extension AuthorDTO {
    func toDomain() -> String? {
        name
    }
}
