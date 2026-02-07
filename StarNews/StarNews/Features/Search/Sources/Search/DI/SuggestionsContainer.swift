//
//  SuggestionsContainer.swift
//  Search
//
//  Created by Baher Tamer on 07/02/2026.
//

import ArticleDetails
import Factory
import SNCore
import SNNetwork
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
            DefaultSuggestionsRouter()
        }
    }
    
    private var suggestionsViewModel: ParameterFactory<SuggestionsRouter, DefaultSuggestionsViewModel> {
        self { @MainActor in
            DefaultSuggestionsViewModel(
                router: $0,
                suggestionsUseCase: self.suggestionsUseCase()
            )
        }
    }
    
    private var suggestionsVC: ParameterFactory<DefaultSuggestionsViewModel, UIViewController> {
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
            DefaultSuggestionsUseCase(
                repository: self.suggestionsRepository()
            )
        }
    }
}

// MARK: - Data Layer
extension Container {
    private var suggestionsRepository: Factory<SuggestionsRepository> {
        self {
            DefaultSuggestionsRepository(
                networkService: self.networkService(),
                mapper: self.suggestionsMapper()
            )
        }
    }
    
    private var suggestionsMapper: Factory<any SuggestionsMapper> {
        self {
            DefaultSuggestionsMapper()
        }
    }
}

