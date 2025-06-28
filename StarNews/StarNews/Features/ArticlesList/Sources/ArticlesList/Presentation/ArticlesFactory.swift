//
//  ArticlesFactory.swift
//  ArticlesList
//
//  Created by Baher Tamer on 19/06/2025.
//

import SNCache
import SNCore
import SNNetwork
import UIKit.UIViewController

public protocol ArticlesFactory {
    @MainActor func create() -> UIViewController
}

public final class DefaultArticlesFactory: ArticlesFactory {
    // MARK: - Life Cycle
    public init() {}

    // MARK: - Config Functions
    public func create() -> UIViewController {
        let networkService = RESTNetworkService()
        let memoryCache = MemoryCacheService<PaginatedData<Article>>()
        let repository = DefaultArticlesRepository(
            cache: memoryCache,
            networkService: networkService
        )
        let useCase = DefaultArticlesUseCase(repository: repository)
        let router = DefaultArticlesRouter()
        let viewModel = DefaultArticlesViewModel(
            router: router,
            useCase: useCase
        )
        let screen = ArticlesScreen(viewModel: viewModel)
        let controller = UIViewController.createHC(with: screen)
        router.screenVC = controller
        return controller
    }
}
