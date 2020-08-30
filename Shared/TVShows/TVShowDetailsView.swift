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

    private var credits: Credits? {
        store.state.tvShows.credits[id]
    }

    private var recommendations: [TVShowListItem]? {
        store.state.tvShows.recommendations[id]
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
           let credits = self.credits,
           let recommendations = self.recommendations {
            TVShowDetails(tvShow: tvShow, credits: credits, recommendations: recommendations)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension TVShowDetailsView {

    private func fetch() {
        guard tvShow == nil else {
            return
        }

        store.send(.tvShows(.fetchTVShowExtended(id: id)))
    }

}

struct TVShowDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        TVShowDetailsView(id: 1)
    }

}
