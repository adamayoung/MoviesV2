//
//  TVShowSeasonDetailsView.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import SwiftUI

struct TVShowSeasonDetailsView: View {

    var tvShowID: TVShow.ID
    var seasonNumber: Int

    @EnvironmentObject private var store: AppStore

    private var season: TVShowSeason? {
        store.state.tvShows.season(seasonNumber, forTVShow: tvShowID)
    }

    var body: some View {
        container
            .onAppear(perform: fetch)
            .navigationTitle(season?.name ?? "")
    }

    @ViewBuilder private var container: some View {
        #if os(iOS)
        content
            .navigationBarTitleDisplayMode(.large)
        #elseif os(macOS)
        content
            .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
        if let season = self.season, let episodes = season.episodes {
            TVShowEpisodesList(episodes: episodes)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension TVShowSeasonDetailsView {

    private func fetch() {
        store.send(.tvShows(.fetchSeason(seasonNumber: seasonNumber, tvShowID: tvShowID)))
    }

}

struct TVShowSeasonDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        TVShowSeasonDetailsView(tvShowID: 1, seasonNumber: 1)
    }

}
