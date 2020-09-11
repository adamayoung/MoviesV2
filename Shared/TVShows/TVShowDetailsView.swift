//
//  TVShowDetailsView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowDetailsView: View {

    var id: TVShow.ID

    @EnvironmentObject private var store: AppStore

    private var tvShow: TVShow? {
        store.state.tvShows.tvShows[id]
    }

    private var seasons: [TVShowSeason]? {
        store.state.tvShows.tvShows[id]?.seasons
    }

    private var credits: Credits? {
        store.state.tvShows.credits[id]
    }

    private var recommendations: [TVShow]? {
        store.state.tvShows.recommendations(forTVShow: id)
    }

    private var title: String {
        tvShow?.name ?? ""
    }

    var body: some View {
        container
            .onAppear(perform: fetch)
            .navigationTitle(title)
    }

    @ViewBuilder private var container: some View {
        #if os(iOS)
        content
            .navigationBarTitleDisplayMode(.inline)
        #elseif os(macOS)
        content
            .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
        if let tvShow = self.tvShow,
           let seasons = self.seasons,
           let credits = self.credits,
           let recommendations = self.recommendations {
            TVShowDetails(tvShow: tvShow, seasons: seasons, credits: credits, recommendations: recommendations)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension TVShowDetailsView {

    private func fetch() {
        store.send(.tvShows(.fetchTVShow(id: id)))

        if seasons == nil {
            store.send(.tvShows(.fetchTVShow(id: id)))
        }

        if credits == nil {
            store.send((.tvShows(.fetchCredits(tvShowID: id))))
        }

        if recommendations == nil {
            store.send(.tvShows(.fetchRecommendations(tvShowID: id)))
        }
    }

}

struct TVShowDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        TVShowDetailsView(id: 1)
    }

}
