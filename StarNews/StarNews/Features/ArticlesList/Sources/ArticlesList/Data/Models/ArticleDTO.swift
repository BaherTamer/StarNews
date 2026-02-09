//
//  ArticleDTO.swift
//  ArticlesList
//
//  Created by Baher Tamer on 09/02/2026.
//

import SNCore

struct ArticleDTO: Domainable {
    let id: Int?
    let title: String?
    let url: String?
    let imageUrl: String?
    let newsSite: String?
}

// MARK: - Mapping Functions
extension ArticleDTO {
    func toDomain() -> Article {
        Article(
            id: id ?? -1,
            title: title ?? "N/A",
            url: url ?? "",
            imageURL: imageUrl ?? "",
            siteName: newsSite ?? "N/A"
        )
    }
}
