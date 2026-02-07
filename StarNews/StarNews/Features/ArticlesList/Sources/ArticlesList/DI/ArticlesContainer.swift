//
//  ArticlesContainer.swift
//  ArticlesList
//
//  Created by Baher Tamer on 07/02/2026.
//

import Factory
import SNCache
import SNNetwork
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
            DefaultArticlesRouter()
        }
    }
    
    private var articlesViewModel: ParameterFactory<ArticlesRouter, ArticlesViewModel> {
        self { @MainActor in
            DefaultArticlesViewModel(
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
            DefaultArticlesUseCase(
                repository: self.articlesRepository()
            )
        }
    }
}

// MARK: - Data Layer
extension Container {
    private var articlesRepository: Factory<ArticlesRepository> {
        self {
            DefaultArticlesRepository(
                cache: self.articlesCache(),
                networkService: self.networkService(),
                mapper: self.articlesMapper()
            )
        }
    }
    
    private var articlesCache: Factory<MemoryCacheService<PaginatedData<Article>>> {
        self {
            MemoryCacheService<PaginatedData<Article>>()
        }
    }
    
    private var articlesMapper: Factory<any ArticlesMapper> {
        self {
            DefaultArticlesMapper()
        }
    }
}
