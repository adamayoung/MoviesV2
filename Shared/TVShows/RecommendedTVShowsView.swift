//
//  RecommendedTVShowsView.swift
//  Movies
//
//  Created by Adam Young on 18/08/2020.
//

import SwiftUI

struct RecommendedTVShowsView: View {

    var tvShowID: TVShow.ID

    @EnvironmentObject private var store: AppStore

    private var tvShows: [TVShowListItem]? {
        store.state.tvShows.recommendations[tvShowID]
    }

    var body: some View {
        content
            .onAppear(perform: fetch)
            .navigationTitle("Recommendations")
    }

    @ViewBuilder private var content: some View {
        if let tvShows = self.tvShows {
            TVShowsList(tvShows: tvShows)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension RecommendedTVShowsView {

    private func fetch() {
        guard tvShows == nil else {
            return
        }

        store.send(.tvShows(.fetchRecommendations(tvShowID: tvShowID)))
    }

}

struct RecommendedTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        RecommendedTVShowsView(tvShowID: 1)
    }

}
