//
//  HomeView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb

struct HomeView: View {

    @EnvironmentObject private var movieStore: MovieStore
    @EnvironmentObject private var tvShowStore: TVShowStore
    @EnvironmentObject private var personStore: PersonStore

    @State private var navigationSelection: HomeList.NavigationSelection?
    @State var isSearchActive = false

    private var trendingMovies: [Movie] {
        movieStore.topTrending
    }

    private var discoverMovies: [Movie] {
        movieStore.topDiscover
    }

    private var trendingTVShows: [TVShow] {
        tvShowStore.topTrending
    }

    private var discoverTVShows: [TVShow] {
        tvShowStore.topDiscover
    }

    private var trendingPeople: [Person] {
        personStore.topTrending
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
        .background(
            NavigationLink(destination: SearchView(), isActive: $isSearchActive) {}
        )
        .accessibility(label: Text("Home View"))
        .accessibility(identifier: "HomeView")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    isSearchActive = true
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
                .accessibility(label: Text("Search"))
                .accessibility(identifier: "Search")
            }
        }
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
            movieStore.fetchTrending()
        }

        if discoverMovies.isEmpty {
            movieStore.fetchDiscover()
        }

        if trendingTVShows.isEmpty {
            tvShowStore.fetchTrending()
        }

        if discoverTVShows.isEmpty {
            tvShowStore.fetchDiscover()
        }

        if trendingPeople.isEmpty {
            personStore.fetchTrending()
        }
    }

}

// struct OverviewView_Previews: PreviewProvider {

//    static var previews: some View {
//        HomeView()
//    }

// }
