//
//  ArticleDetailsViewModel.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Observation
import SNCore

protocol ArticleDetailsViewModel: ViewModel {
    var article: ArticleDetails? { get }
}

@Observable
final class DefaultArticleDetailsViewModel: ArticleDetailsViewModel {
    // MARK: - Inputs
    private let articleId: Int
    private let router: ArticleDetailsRouter
    
    // MARK: - UseCases
    private let articleDetailsUseCase: ArticleDetailsUseCase

    // MARK: - Variables
    var state = ViewState.initial
    var article: ArticleDetails?
    
    // MARK: - Life Cycle
    init(
        articleId: Int,
        router: ArticleDetailsRouter,
        articleDetailsUseCase: ArticleDetailsUseCase
    ) {
        self.articleId = articleId
        self.router = router
        self.articleDetailsUseCase = articleDetailsUseCase
    }
    
    func onInit() {
        getArticleDetails()
    }
    
    func errorAction() {
        getArticleDetails()
    }
}

// MARK: - Private Helpers
extension DefaultArticleDetailsViewModel {
    private func getArticleDetails() {
        Task { [weak self] in
            self?.updateState(.loading)
            do {
                let articleDetails = try await self?.articleDetailsUseCase.execute(
                    id: self?.articleId ?? 0
                )
                self?.setArticleDetails(articleDetails)
                self?.updateState(.loaded)
            } catch {
                self?.updateState(.error)
            }
        }
    }
    
    private func setArticleDetails(_ details: ArticleDetails?) {
        guard let details else { return }
        article = details
    }
}
