//
//  SearchView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct SearchView: View {

    @EnvironmentObject private var store: AppStore

    @State private var searchText: String = ""

    private var isSearching: Bool {
        store.state.search.isSearching
    }

    private var results: [Media] {
        store.state.search.results
    }

    var body: some View {
        MultiTypeList(searchText: $searchText, isSearching: isSearching, results: results)
            .navigationTitle("Search")
            .onChange(of: searchText) { query in
                store.send(.search(.search(query: query)))
            }
    }

}

struct SearchView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView()
    }

}
