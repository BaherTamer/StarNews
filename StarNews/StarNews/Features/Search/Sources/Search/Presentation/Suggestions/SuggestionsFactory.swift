//
//  SuggestionsFactory.swift
//  Search
//
//  Created by Baher Tamer on 03/07/2025.
//

import SNCore
import SNNetwork
import UIKit.UIViewController

public protocol SuggestionsFactory {
    @MainActor func create() -> UIViewController
}

public final class DefaultSuggestionsFactory: SuggestionsFactory {
    // MARK: - Life Cycle
    public init() {}

    // MARK: - Config Functions
    public func create() -> UIViewController {
        let networkService = RESTNetworkService()
        let repository = DefaultSuggestionsRepository(
            networkService: networkService
        )
        let useCase = DefaultSuggestionsUseCase(repository: repository)
        let router = DefaultSuggestionsRouter()
        let viewModel = DefaultSuggestionsViewModel(
            router: router,
            useCase: useCase
        )
        let screen = SuggestionsScreen(viewModel: viewModel)
        let controller = UIViewController.createHC(with: screen)
        router.screenVC = controller
        return controller
    }
}
