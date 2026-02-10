//
//  ArticleDetailsViewModel.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Foundation
import Observation
import SNCore

protocol ArticleDetailsViewModel: ViewModel {
    var article: ArticleDetails? { get }
    
    func openSafari(urlString: String)
    func shareArticle(urlString: String)
}

@Observable
final class ArticleDetailsViewModelImpl: ArticleDetailsViewModel {
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

// MARK: - Core Functinos
extension ArticleDetailsViewModelImpl {
    func openSafari(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        router.openSafari(url: url)
    }
    
    func shareArticle(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        router.presentShareSheet(url: url)
    }
}

// MARK: - Private Helpers
extension ArticleDetailsViewModelImpl {
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
