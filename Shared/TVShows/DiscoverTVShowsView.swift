//
//  DiscoverTVShowsView.swift
//  TVShows
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct DiscoverTVShowsView: View {

    @EnvironmentObject private var store: AppStore

    private var tvShows: [TVShow] {
        store.state.tvShows.discover
    }

    var body: some View {
        TVShowsCollection(tvShows: tvShows, tvShowDidAppear: tvShowDidAppear)
            .overlay(Group {
                if tvShows.isEmpty {
                    ProgressView()
                }
            })
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

    private func tvShowDidAppear(_ tvShow: TVShow, offset: Int) {
        store.send(.tvShows(.fetchNextDiscoverIfNeeded(currentTVShow: tvShow, offset: offset)))
    }

}

struct DiscoverTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        DiscoverTVShowsView()
    }

}
