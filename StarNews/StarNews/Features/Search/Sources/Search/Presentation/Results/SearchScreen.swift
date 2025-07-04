//
//  SearchScreen.swift
//  Search
//
//  Created by Baher Tamer on 05/07/2025.
//

import SwiftUI

struct SearchScreen: View {
    // MARK: - Input
    let viewModel: SearchViewModel
    
    // MARK: - Body
    var body: some View {
        Text(verbatim: "Search Results = \(viewModel.searchResults.count)")
    }
}
