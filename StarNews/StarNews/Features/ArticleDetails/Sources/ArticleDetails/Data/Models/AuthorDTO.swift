//
//  AuthorDTO.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 09/02/2026.
//

struct AuthorDTO: Decodable {
    let name: String?
}

// MARK: - Mapping Functions
extension AuthorDTO {
    func toDomain() -> String? {
        name
    }
}

extension [AuthorDTO]? {
    func toDomain() -> [String] {
        self?.compactMap {
            $0.toDomain()
        } ?? []
    }
}
