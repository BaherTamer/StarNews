//
//  ArticleDetailsContainer.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 07/02/2026.
//

import Factory
import SNCache
import UIKit.UIViewController

public extension Container {
    var articleDetailsScreen: ParameterFactory<Int, UIViewController> {
        self { @MainActor in
            var router = self.articleDetailsRouter()
            let viewModel = self.articleDetailsViewModel((articleId: $0, router: router))
            let articleDetailsVC = self.articleDetailsVC(viewModel)
            router.screenVC = articleDetailsVC
            return articleDetailsVC
        }
    }
}

// MARK: - Presentation Layer
extension Container {
    private var articleDetailsRouter: Factory<ArticleDetailsRouter> {
        self {
            DefaultArticleDetailsRouter()
        }
    }
    
    private var articleDetailsViewModel: ParameterFactory<
        (articleId: Int, router: ArticleDetailsRouter),
        ArticleDetailsViewModel
    > {
        self { @MainActor in
            DefaultArticleDetailsViewModel(
                articleId: $0.articleId,
                router: $0.router,
                articleDetailsUseCase: self.articleDetailsUseCase()
            )
        }
    }
    
    private var articleDetailsVC: ParameterFactory<ArticleDetailsViewModel, UIViewController> {
        self { @MainActor in
            let screen = ArticleDetailsScreen(viewModel: $0)
            let controller = UIViewController.createHC(with: screen)
            return controller
        }
    }
}

// MARK: - Domain Layer
extension Container {
    private var articleDetailsUseCase: Factory<ArticleDetailsUseCase> {
        self {
            DefaultArticleDetailsUseCase(
                repository: self.articleDetailsRepository()
            )
        }
    }
}

// MARK: - Data Layer
extension Container {
    private var articleDetailsRepository: Factory<ArticleDetailsRepository> {
        self {
            DefaultArticleDetailsRepository(
                cache: self.articleDetailsCache(),
                networkService: self.networkService()
            )
        }
    }
    
    private var articleDetailsCache: Factory<MemoryCacheService<ArticleDetails>> {
        self {
            MemoryCacheService<ArticleDetails>()
        }
    }
}
