//
//  ArticlesMapper.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import Shared
import SNCore
import Foundation.NSData

final class ArticlesMapper: Mapper<PaginatedData<Article>> {
    // MARK: - Base Functions
    override func parse(_ data: Data) throws -> PaginatedData<Article> {
        let response: DataResponse = try decode(data: data)
        let articles = mapResponse(response)
        return articles
    }
}

// MARK: - Mapping Functions
extension ArticlesMapper {
    private func mapResponse(_ response: DataResponse) -> PaginatedData<Article> {
        let articles = response.results?.compactMap(mapArticle) ?? []
        let pageInfo = mapPageInfo(response)
        let data = PaginatedData(items: articles, pageInfo: pageInfo)
        return data
    }

    private func mapPageInfo(_ response: DataResponse) -> PageInfo {
        let info = extractLimitAndOffset(from: response.next)
        let currentPage = (info?.offset ?? 1) / (info?.limit ?? 1)
        let pageSize = info?.limit ?? 10
        let pageInfo = PageInfo(
            currentPage: currentPage,
            pageSize: pageSize,
            itemsCount: response.count ?? 0
        )
        return pageInfo
    }

    private func mapArticle(_ article: ArticleModel) -> Article {
        Article(
            id: article.id ?? -1,
            title: article.title ?? "N/A",
            url: article.url ?? "",
            imageURL: article.imageUrl ?? "",
            siteName: article.newsSite ?? "N/A"
        )
    }
}

// MARK: - Models
extension ArticlesMapper {
    fileprivate struct DataResponse: Decodable {
        let count: Int?
        let next: String?
        let results: [ArticleModel]?
    }

    fileprivate struct ArticleModel: Decodable {
        let id: Int?
        let title: String?
        let url: String?
        let imageUrl: String?
        let newsSite: String?
    }
}
