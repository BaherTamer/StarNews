//
//  ArticleDetailsMapper.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Foundation.NSData
import SNCore

final class ArticleDetailsMapper: Mapper<ArticleDetails> {
    // MARK: - Base Functions
    override func parse(_ data: Data) throws -> ArticleDetails {
        let response: ArticleModel = try decode(data: data)
        let article = mapArticle(response)
        return article
    }
}

// MARK: - Mapping Functions
extension ArticleDetailsMapper {
    private func mapArticle(_ article: ArticleModel) -> ArticleDetails {
        let date = parseISO8601Date(from: article.publishedAt)
        let authors = mapAuthors(article.authors)
        let articleDetails = ArticleDetails(
            id: article.id ?? -1,
            title: article.title ?? "N/A",
            authors: authors,
            url: article.url ?? "",
            imageURL: article.imageUrl ?? "",
            siteName: article.newsSite ?? "N/A",
            summary: article.summary ?? "",
            publishDate: date ?? .now
        )
        return articleDetails
    }
    
    private func mapAuthors(_ authors: [AuthorModel]?) -> [String] {
        authors?.compactMap(mapAuthor) ?? []
    }
    
    private func mapAuthor(_ author: AuthorModel) -> String? {
        author.name
    }
    
    private func parseISO8601Date(from string: String?) -> Date? {
        guard let string else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: string)
    }
}

// MARK: - Models
extension ArticleDetailsMapper {
    fileprivate struct ArticleModel: Decodable {
        let id: Int?
        let title: String?
        let url: String?
        let imageUrl: String?
        let newsSite: String?
        let summary: String?
        let publishedAt: String?
        let authors: [AuthorModel]?
    }
    
    fileprivate struct AuthorModel: Decodable {
        let name: String?
    }
}
