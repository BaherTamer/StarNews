//
//  SearchContainer.swift
//  Search
//
//  Created by Baher Tamer on 07/02/2026.
//

import Factory
import Shared
import SNCache
import UIKit.UIViewController

public extension Container {
    var searchScreen: ParameterFactory<String, UIViewController> {
        self { @MainActor in
            var router = self.searchRouter()
            let viewModel = self.searchViewModel((query: $0, router: router))
            let searchVC = self.searchVC(viewModel)
            router.screenVC = searchVC
            return searchVC
        }
    }
}

// MARK: - Presentation Layer
extension Container {
    private var searchRouter: Factory<SearchRouter> {
        self {
            SearchRouterImpl()
        }
    }
    
    private var searchViewModel: ParameterFactory<
        (query: String, router: SearchRouter),
        SearchViewModel
    > {
        self { @MainActor in
            SearchViewModelImpl(
                query: $0.query,
                router: $0.router,
                searchUseCase: self.searchUseCase()
            )
        }
    }
    
    private var searchVC: ParameterFactory<SearchViewModel, UIViewController> {
        self { @MainActor in
            let screen = SearchScreen(viewModel: $0)
            let controller = UIViewController.createHC(with: screen)
            return controller
        }
    }
}

// MARK: - Domain Layer
extension Container {
    private var searchUseCase: Factory<SearchUseCase> {
        self {
            SearchUseCaseImpl(
                repository: self.searchRepository()
            )
        }
    }
}

// MARK: - Data Layer
extension Container {
    private var searchRepository: Factory<SearchRepository> {
        self {
            SearchRepositoryImpl(
                cache: self.searchCache(),
                networkService: self.networkService()
            )
        }
    }
    
    private var searchCache: Factory<MemoryCacheService<PaginatedData<SearchResult>>> {
        self {
            MemoryCacheService<PaginatedData<SearchResult>>()
        }
    }
}
