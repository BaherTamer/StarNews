//
//  ArticlesContainer.swift
//  ArticlesList
//
//  Created by Baher Tamer on 07/02/2026.
//

import Factory
import SNCache
import Shared
import UIKit.UIViewController

public extension Container {
    var articlesScreen: Factory<UIViewController> {
        self { @MainActor in
            var router = self.articlesRouter()
            let viewModel = self.articlesViewModel(router)
            let articlesVC = self.articlesVC(viewModel)
            router.screenVC = articlesVC
            return articlesVC
        }
    }
}

// MARK: - Presentation Layer
extension Container {
    private var articlesRouter: Factory<ArticlesRouter> {
        self {
            ArticlesRouterImpl()
        }
    }
    
    private var articlesViewModel: ParameterFactory<ArticlesRouter, ArticlesViewModel> {
        self { @MainActor in
            ArticlesViewModelImpl(
                router: $0,
                articlesUseCase: self.articlesUseCase()
            )
        }
    }
    
    private var articlesVC: ParameterFactory<ArticlesViewModel, UIViewController> {
        self { @MainActor in
            let screen = ArticlesScreen(viewModel: $0)
            let controller = UIViewController.createHC(with: screen)
            return controller
        }
    }
}

// MARK: - Domain Layer
extension Container {
    private var articlesUseCase: Factory<ArticlesUseCase> {
        self {
            ArticlesUseCaseImpl(
                repository: self.articlesRepository()
            )
        }
    }
}

// MARK: - Data Layer
extension Container {
    private var articlesRepository: Factory<ArticlesRepository> {
        self {
            ArticlesRepositoryImpl(
                cache: self.articlesCache(),
                networkService: self.networkService()
            )
        }
    }
    
    private var articlesCache: Factory<MemoryCacheService<PaginatedData<Article>>> {
        self {
            MemoryCacheService<PaginatedData<Article>>()
        }
    }
}
