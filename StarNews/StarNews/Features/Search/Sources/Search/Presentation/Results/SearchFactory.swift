//
//  SearchFactory.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import SNCache
import Shared
import SNNetwork
import UIKit.UIViewController

public protocol SearchFactory {
    @MainActor func create(with query: String) -> UIViewController
}

public final class DefaultSearchFactory: SearchFactory {
    // MARK: - Life Cycle
    public init() {}

    // MARK: - Config Functions
    public func create(with query: String) -> UIViewController {
        let networkService = RESTNetworkService()
        let memoryCache = MemoryCacheService<PaginatedData<SearchResult>>()
        let repository = DefaultSearchRepository(
            cache: memoryCache,
            networkService: networkService
        )
        let useCase = DefaultSearchUseCase(repository: repository)
        let router = DefaultSearchRouter()
        let viewModel = DefaultSearchViewModel(
            query: query,
            router: router,
            useCase: useCase
        )
        let screen = SearchScreen(viewModel: viewModel)
        let controller = UIViewController.createHC(with: screen)
        router.screenVC = controller
        return controller
    }
}
