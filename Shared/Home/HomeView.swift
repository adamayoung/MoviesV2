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

    private var trendingMovies: [MovieListItem] {
        store.state.movies.topTrending
    }

    private var discoverMovies: [MovieListItem] {
        store.state.movies.topDiscover
    }

    private var trendingTVShows: [TVShowListItem] {
        store.state.tvShows.topTrending
    }

    private var discoverTVShows: [TVShowListItem] {
        store.state.tvShows.topDiscover
    }

    private var trendingPeople: [PersonListItem] {
        store.state.people.topTrending
    }

    var body: some View {
        HomeList(
            trendingMovies: trendingMovies,
            discoverMovies: discoverMovies,
            trendingTVShows: trendingTVShows,
            discoverTVShows: discoverTVShows,
            trendingPeople: trendingPeople
        )
        .onAppear(perform: fetch)
        .navigationTitle("Home")
    }

}

extension HomeView {

    private func fetch() {
        if trendingMovies.isEmpty {
            store.send(.movies(.fetchTrending))
        }

        if discoverMovies.isEmpty {
            store.send(.movies(.fetchDiscover))
        }

        if trendingTVShows.isEmpty {
            store.send(.tvShows(.fetchTrending))
        }

        if discoverTVShows.isEmpty {
            store.send(.tvShows(.fetchDiscover))
        }

        if trendingPeople.isEmpty {
            store.send(.people(.fetchTrending))
        }
    }

}

//struct OverviewView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        HomeView()
//    }
//
//}
