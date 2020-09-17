//
//  SearchView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct SearchView: View {

    @StateObject private var searchStore = SearchStore()

    @State private var searchText: String = ""
    @State private var isSearching = false

    private var results: [Media] {
        searchStore.results
    }

    var body: some View {
        MultiTypeList(searchText: $searchText, isSearching: isSearching, results: results)
            .navigationTitle("Search")
            .onChange(of: searchText, perform: search)
            .onOpenURL(perform: openURL)
    }

}

extension SearchView {

    private func openURL(url: URL) {
        guard
            url.isDeeplink,
            url.host == "search",
            url.pathComponents.isEmpty,
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let qQueryItem = urlComponents.queryItems?.first(where: { $0.name == "q" }),
            let searchText = qQueryItem.value
        else {
            return
        }

        self.searchText = searchText
    }

    private func search(query: String) {
        isSearching = true
        searchStore.search(query: query) { _ in
            isSearching = false
        }
    }

}

struct SearchView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView()
    }

}
