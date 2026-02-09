//
//  SuggestionsContainer.swift
//  Search
//
//  Created by Baher Tamer on 07/02/2026.
//

import Factory
import UIKit.UIViewController

public extension Container {
    var suggestionsScreen: Factory<UIViewController> {
        self { @MainActor in
            var router = self.suggestionsRouter()
            let viewModel = self.suggestionsViewModel(router)
            let suggestionsVC = self.suggestionsVC(viewModel)
            router.screenVC = suggestionsVC
            return suggestionsVC
        }
    }
}

// MARK: - Presentation Layer
extension Container {
    private var suggestionsRouter: Factory<SuggestionsRouter> {
        self {
            SuggestionsRouterImpl()
        }
    }
    
    private var suggestionsViewModel: ParameterFactory<SuggestionsRouter, SuggestionsViewModelImpl> {
        self { @MainActor in
            SuggestionsViewModelImpl(
                router: $0,
                suggestionsUseCase: self.suggestionsUseCase()
            )
        }
    }
    
    private var suggestionsVC: ParameterFactory<SuggestionsViewModelImpl, UIViewController> {
        self { @MainActor in
            let screen = SuggestionsScreen(viewModel: $0)
            let controller = UIViewController.createHC(with: screen)
            return controller
        }
    }
}

// MARK: - Domain Layer
extension Container {
    private var suggestionsUseCase: Factory<SuggestionsUseCase> {
        self {
            SuggestionsUseCaseImpl(
                repository: self.suggestionsRepository()
            )
        }
    }
}

// MARK: - Data Layer
extension Container {
    private var suggestionsRepository: Factory<SuggestionsRepository> {
        self {
            SuggestionsRepositoryImpl(
                networkService: self.networkService()
            )
        }
    }
}
