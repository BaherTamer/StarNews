//
//  SearchInput.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

struct SearchInput {
    let query: String
    let page: Int
    let limit: Int
}

// MARK: - Private Helpers
extension SearchInput {
    var offset: String {
        ((page - 1) * limit).description
    }
}
