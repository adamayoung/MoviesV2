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
    @State private var navigationSelection: HomeList.NavigationSelection?

    private var trendingMovies: [Movie] {
        store.state.movies.topTrending
    }

    private var discoverMovies: [Movie] {
        store.state.movies.topDiscover
    }

    private var trendingTVShows: [TVShow] {
        store.state.tvShows.topTrending
    }

    private var discoverTVShows: [TVShow] {
        store.state.tvShows.topDiscover
    }

    private var trendingPeople: [Person] {
        store.state.people.topTrending
    }

    var body: some View {
        HomeList(
            trendingMovies: trendingMovies,
            discoverMovies: discoverMovies,
            trendingTVShows: trendingTVShows,
            discoverTVShows: discoverTVShows,
            trendingPeople: trendingPeople,
            navigationSelection: $navigationSelection
        )
        .onAppear(perform: fetch)
        .onOpenURL(perform: openURL)
        .navigationTitle("Home")
    }

}

extension HomeView {

    private func openURL(url: URL) {
        guard url.isDeeplink else {
            return
        }

        guard let navigationSelection = HomeList.NavigationSelection(deepLink: url) else {
            return
        }

        if self.navigationSelection == nil {
            self.navigationSelection = navigationSelection
            return
        }

        self.navigationSelection = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationSelection = navigationSelection
        }
    }

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
