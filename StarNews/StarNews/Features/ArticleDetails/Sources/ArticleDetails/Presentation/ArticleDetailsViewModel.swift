//
//  ArticleDetailsViewModel.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import Observation
import SNCore

protocol ArticleDetailsViewModel: ViewModel {
    
}

@Observable
final class DefaultArticleDetailsViewModel: ArticleDetailsViewModel {
    // MARK: - Inputs
    private let articleId: Int
    private let router: ArticleDetailsRouter
    
    // MARK: - UseCases
    private let useCase: ArticleDetailsUseCase

    // MARK: - Variables
    var state = ViewState.initial
    var articleDetails: ArticleDetails?
    
    // MARK: - Life Cycle
    init(
        articleId: Int,
        router: ArticleDetailsRouter,
        useCase: ArticleDetailsUseCase
    ) {
        self.articleId = articleId
        self.router = router
        self.useCase = useCase
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
            guard let self else { return }
            updateState(.loading)
            do {
                let articleDetails = try await useCase.execute(id: articleId)
                setArticleDetails(articleDetails)
                updateState(.loaded)
            } catch {
                updateState(.error)
            }
        }
    }
    
    private func setArticleDetails(_ details: ArticleDetails) {
        articleDetails = details
    }
    
    private func updateState(_ state: ViewState) {
        self.state = state
    }
}
