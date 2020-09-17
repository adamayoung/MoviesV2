//
//  TrendingTVShowsView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TrendingTVShowsView: View {

    @EnvironmentObject private var tvShowStore: TVShowStore

    private var tvShows: [TVShow] {
        tvShowStore.trending
    }

    var body: some View {
        TVShowsCollection(tvShows: tvShows, tvShowDidAppear: tvShowDidAppear)
            .overlay(Group {
                if tvShows.isEmpty {
                    ProgressView()
                }
            })
            .onAppear(perform: fetch)
            .navigationTitle("Trending TV Shows")
    }

}

extension TrendingTVShowsView {

    private func fetch() {
        guard tvShows.isEmpty else {
            return
        }

        tvShowStore.fetchTrending()
    }

    private func tvShowDidAppear(_ tvShow: TVShow, offset: Int) {
        tvShowStore.fetchNextTrendingIfNeeded(currentTVShow: tvShow, offset: offset)
    }

}

struct TrendingTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        TrendingTVShowsView()
    }

}
