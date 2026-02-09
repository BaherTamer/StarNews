//
//  ArticleDetailsDTO.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 09/02/2026.
//

struct ArticleDetailsDTO: Decodable {
    let id: Int?
    let title: String?
    let url: String?
    let imageUrl: String?
    let newsSite: String?
    let summary: String?
    let publishedAt: String?
    let authors: [AuthorDTO]?
}

// MARK: - Mapping Functions
extension ArticleDetailsDTO {
    func toDomain() -> ArticleDetails {
        let date = publishedAt.parseISO8601Date()
        let authorNames = authors.toDomain()
        let articleDetails = ArticleDetails(
            id: id ?? -1,
            title: title ?? "N/A",
            authors: authorNames,
            url: url ?? "",
            imageURL: imageUrl ?? "",
            siteName: newsSite ?? "N/A",
            summary: summary ?? "",
            publishDate: date ?? .now
        )
        return articleDetails
    }
}
