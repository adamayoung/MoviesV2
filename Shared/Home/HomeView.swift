//
//  HomeView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb

struct HomeView: View {

    @EnvironmentObject private var store: AppStore

    var body: some View {
        HomeList(
            trendingMovies: store.state.movies.topTrending,
            discoverMovies: store.state.movies.topDiscover,
            trendingTVShows: store.state.tvShows.topTrending,
            discoverTVShows: store.state.tvShows.topDiscover
        )
        .onAppear(perform: fetch)
        .navigationTitle("Home")
    }

}

extension HomeView {

    private func fetch() {
        store.send(.movies(.fetchTrending))
        store.send(.movies(.fetchDiscover))
        store.send(.tvShows(.fetchTrending))
        store.send(.tvShows(.fetchDiscover))
    }

}

//struct OverviewView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        HomeView()
//    }
//
//}
