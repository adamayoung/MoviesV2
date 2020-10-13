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

    private var isSearching: Bool {
        searchStore.isSearching
    }

    private var media: [Media]? {
        searchStore.results
    }

    var body: some View {
        MediaCollection(searchText: $searchText, media: media ?? [], mediaItemDidAppear: mediaItemDidAppear)
            .overlay(overlay)
            .navigationTitle("Search")
            .onChange(of: searchText, perform: search)
            .onOpenURL(perform: openURL)
    }

    @ViewBuilder private var overlay: some View {
        if isSearching && (media?.isEmpty ?? true || media == nil) {
            ProgressView()
        }

        Group {
            if !isSearching && media == nil {
                Text("Search for Movies, TV Shows and People")
            }

            if !isSearching && !searchText.isEmpty && (media?.isEmpty ?? false) {
                Text("No results found")
            }
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
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
        searchStore.search(query: query)
    }

    private func mediaItemDidAppear(currentMediaItem mediaItem: Media, offset: Int) {
        searchStore.fetchNextPageIfNeeded(currentMediaItem: mediaItem, offset: offset)
    }

}

struct SearchView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView()
    }

}
