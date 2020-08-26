//
//  DiscoverTVShowsView.swift
//  TVShows
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct DiscoverTVShowsView: View {

    @EnvironmentObject private var store: AppStore

    private var tvShows: [TVShowListItem] {
        store.state.tvShows.discover
    }

    var body: some View {
        TVShowsList(tvShows: tvShows, tvShowDidAppear: tvShowDidAppear)
            .onAppear(perform: fetch)
            .navigationTitle("Discover TV Shows")
    }

}

extension DiscoverTVShowsView {

    private func fetch() {
        guard tvShows.isEmpty else {
            return
        }

        store.send(.tvShows(.fetchDiscover))
    }

    private func tvShowDidAppear(_ tvShow: TVShowListItem) {
//        store.fetchNextDiscoverPageIfNeeded(currentTVShow: tvShow)
    }

}

struct DiscoverTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        DiscoverTVShowsView()
    }

}
