//
//  ArticlesViewModelTests.swift
//  ArticlesList
//
//  Created by Baher Tamer on 06/07/2025.
//

import Testing
@testable import ArticlesList

@MainActor
final class ArticlesViewModelTests {
    // MARK: - Variables
    private var viewModel: ArticlesViewModel!
    private var router: TestableArticlesRouter!
    private var useCase: TestableArticlesUseCase!
    
    // MARK: - Life Cycle
    init() {
        self.router = MockArticlesRouter()
        self.useCase = StubArticlesUseCase()
        self.viewModel = DefaultArticlesViewModel(
            router: router,
            useCase: useCase
        )
    }
}
