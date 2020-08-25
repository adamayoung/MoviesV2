//
//  TrendingTVShowsView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TrendingTVShowsView: View {

    @EnvironmentObject private var store: AppStore

    private var tvShows: [TVShowListItem] {
        store.state.tvShows.discover
    }

    var body: some View {
        TVShowsList(tvShows: tvShows, tvShowDidAppear: tvShowDidAppear)
            .onAppear(perform: fetch)
            .navigationTitle("Trending TV Shows")
    }

}

extension TrendingTVShowsView {

    private func fetch() {
        guard tvShows.isEmpty else {
            return
        }

        store.send(.tvShows(.fetchTrending))
    }

    private func tvShowDidAppear(_ tvShow: TVShowListItem) {
//        store.fetchNextTrendingPageIfNeeded(currentTVShow: tvShow)
    }

}

struct TrendingTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        TrendingTVShowsView()
    }

}
