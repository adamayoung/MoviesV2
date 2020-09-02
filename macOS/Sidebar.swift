//
//  Sidebar.swift
//  Movies (macOS)
//
//  Created by Adam Young on 24/07/2020.
//

import SwiftUI

struct Sidebar: View {

    enum NavigationItem: Int {
        case home
        case search
        case favourites
        case watchList
        case trendingMovies
        case discoverMovies
        case trendingTVShows
        case discoverTVShows

        init?(deepLink url: URL) {
            switch url.host {
            case "home":
                self = .home

            default:
                return nil
            }
        }
    }

    @EnvironmentObject private var store: AppStore
    @State private var selection: NavigationItem?

    var body: some View {
        List(selection: $selection) {
            NavigationLink(destination: HomeView()) {
                Label("Home", systemImage: "house.fill")
            }
            .accessibility(label: Text("Home"))
            .tag(NavigationItem.home)

            Section {
                NavigationLink(destination: FavouritesView()) {
                    Label("Favourites", systemImage: "heart.circle")
                }
                .accessibility(label: Text("Favourites"))
                .tag(NavigationItem.favourites)
            }

            Section(header: Text("Movies")) {
                NavigationLink(destination: TrendingMoviesView()) {
                    Label("Trending", systemImage: "film")
                }
                .accessibility(label: Text("Trending Movies"))
                .tag(NavigationItem.trendingMovies)

                NavigationLink(destination: DiscoverMoviesView()) {
                    Label("Discover", systemImage: "film")
                }
                .accessibility(label: Text("Discover Movies"))
                .tag(NavigationItem.discoverMovies)
            }
            .accessibility(label: Text("Movies"))

            Section(header: Text("TV Shows")) {
                NavigationLink(destination: TrendingTVShowsView()) {
                    Label("Trending", systemImage: "tv")
                }
                .accessibility(label: Text("Trending TV Shows"))
                .tag(NavigationItem.trendingTVShows)

                NavigationLink(destination: DiscoverTVShowsView()) {
                    Label("Discover", systemImage: "tv")
                }
                .accessibility(label: Text("Discover TV Shows"))
                .tag(NavigationItem.discoverTVShows)
            }
            .accessibility(label: Text("TV Shows"))
        }
    }
}

struct Sidebar_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            Sidebar()
                .listStyle(SidebarListStyle())

            Text("Content")

            Text("Content")
        }
    }

}
