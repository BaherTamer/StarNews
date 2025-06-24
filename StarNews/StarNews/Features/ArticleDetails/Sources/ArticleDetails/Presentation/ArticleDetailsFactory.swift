//
//  ArticleDetailsFactory.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 24/06/2025.
//

import SNCache
import SNCore
import SNNetwork
import UIKit.UIViewController

public protocol ArticleDetailsFactory {
    @MainActor func create(with articleId: Int) -> UIViewController
}

public final class DefaultArticleDetailsFactory: ArticleDetailsFactory {
    // MARK: - Life Cycle
    public init() {}

    // MARK: - Config Functions
    public func create(with articleId: Int) -> UIViewController {
        let networkService = RESTNetworkService()
        let memoryCache = MemoryCacheService<ArticleDetails>()
        let repository = DefaultArticleDetailsRepository(
            cache: memoryCache,
            networkService: networkService
        )
        let useCase = DefaultArticleDetailsUseCase(repository: repository)
        let router = DefaultArticleDetailsRouter()
        let viewModel = DefaultArticleDetailsViewModel(
            articleId: articleId,
            router: router,
            useCase: useCase
        )
        let screen = ArticleDetailsScreen(viewModel: viewModel)
        let controller = UIViewController.createHC(with: screen)
        router.screenVC = controller
        return controller
    }
}
