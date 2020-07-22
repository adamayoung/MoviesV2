//
//  SearchView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject private(set) var viewModel: SearchViewModel

    init(viewModel: SearchViewModel = SearchViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        SearchResultsList(searchText: $viewModel.searchText, isSearching: viewModel.isSearching, results: viewModel.results)
            .navigationTitle("Search")
    }

}

struct SearchView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView()
    }

}
