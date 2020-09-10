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

    private var tvShows: [TVShow]? {
        store.state.tvShows.recommendations(forTVShow: tvShowID)
    }

    var body: some View {
        content
            .overlay(Group {
                if tvShows == nil {
                    ProgressView()
                }
            })
            .onAppear(perform: fetch)
            .navigationTitle("Recommendations")
    }

    @ViewBuilder private var content: some View {
        if let tvShows = self.tvShows {
            TVShowsCollection(tvShows: tvShows)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            List { }
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
