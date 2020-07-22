//
//  AppWatchNavigation.swift
//  Movies (watchOS Extension)
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct AppWatchNavigation: View {

    @State private var selection: NavigationItem? = .trendingMovies

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Search")) {
                    NavigationLink(
                        destination: SearchView(),
                        tag: NavigationItem.search,
                        selection: $selection) {
                        navLabel("Search", iconName: "magnifyingglass")
                    }
                    .accessibility(label: Text("Search"))
                }

                Section(header: Text("Movies")) {
                    NavigationLink(
                        destination: TrendingMoviesView(),
                        tag: NavigationItem.trendingMovies,
                        selection: $selection) {
                        navLabel("Trending", iconName: "film")
                    }
                    .accessibility(label: Text("Trending Movies"))

                    NavigationLink(
                        destination: DiscoverMoviesView(),
                        tag: NavigationItem.discoverMovies,
                        selection: $selection) {
                        navLabel("Discover", iconName: "film")
                    }
                    .accessibility(label: Text("Trending Movies"))
                }

                Section(header: Text("TV Shows")) {
                    NavigationLink(
                        destination: TrendingTVShowsView(),
                        tag: NavigationItem.trendingTVShows,
                        selection: $selection) {
                        navLabel("Trending", iconName: "tv")
                    }
                    .accessibility(label: Text("Trending TV Shows"))

                    NavigationLink(
                        destination: DiscoverTVShowsView(),
                        tag: NavigationItem.discoverTVShows,
                        selection: $selection) {
                        navLabel("Discover", iconName: "tv")
                    }
                    .accessibility(label: Text("Trending TV Shows"))
                }
            }
            .navigationTitle("Movies")
        }
    }

    private func navLabel(_ title: String, iconName: String) -> some View {
        Label(title: {
            Text(title)
        }, icon: {
            Image(systemName: iconName)
                .imageScale(.large)
                .foregroundColor(.accentColor)
        })
    }

}

extension AppWatchNavigation {

    enum NavigationItem: Int {
        case trendingMovies
        case discoverMovies
        case trendingTVShows
        case discoverTVShows
        case search
    }

}

struct AppWatchNavigation_Previews: PreviewProvider {

    static var previews: some View {
        AppWatchNavigation()
    }

}
