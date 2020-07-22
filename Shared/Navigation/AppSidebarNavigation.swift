//
//  AppSidebarNavigation.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct AppSidebarNavigation: View {

    @State private var selection: NavigationItem? = .home

    var sidebar: some View {
        List {
            NavigationLink(
                destination: HomeView(),
                tag: NavigationItem.home,
                selection: $selection) {
                Label("Home", systemImage: "house.fill")
            }
            .accessibility(label: Text("Home"))

            NavigationLink(
                destination: SearchView(),
                tag: NavigationItem.search,
                selection: $selection) {
                Label("Search", systemImage: "magnifyingglass")
            }
            .accessibility(label: Text("Search"))

            NavigationLink(
                destination: FavouritesView(),
                tag: NavigationItem.favourites,
                selection: $selection) {
                Label("Favourites", systemImage: "heart.circle")
            }
            .accessibility(label: Text("Favourites"))

            NavigationLink(
                destination: WatchListView(),
                tag: NavigationItem.watchList,
                selection: $selection) {
                Label("Watch List", systemImage: "eyeglasses")
            }
            .accessibility(label: Text("Watch List"))

            Section(header: Text("Movies")) {
                NavigationLink(
                    destination: TrendingMoviesView(),
                    tag: NavigationItem.trendingMovies,
                    selection: $selection) {
                    Label("Trending", systemImage: "film")
                }
                .accessibility(label: Text("Trending Movies"))

                NavigationLink(
                    destination: DiscoverMoviesView(),
                    tag: NavigationItem.discoverMovies,
                    selection: $selection) {
                    Label("Discover", systemImage: "film")
                }
                .accessibility(label: Text("Discover Movies"))
            }
            .accessibility(label: Text("Movies"))

            Section(header: Text("TV Shows")) {
                NavigationLink(
                    destination: TrendingTVShowsView(),
                    tag: NavigationItem.trendingTVShows,
                    selection: $selection) {
                    Label("Trending", systemImage: "tv")
                }
                .accessibility(label: Text("Trending TV Shows"))

                NavigationLink(
                    destination: DiscoverTVShowsView(),
                    tag: NavigationItem.discoverTVShows,
                    selection: $selection) {
                    Label("Discover", systemImage: "tv")
                }
                .accessibility(label: Text("Discover TV Shows"))
            }
            .accessibility(label: Text("TV Shows"))
        }
        .navigationTitle("Menu")
        .listStyle(SidebarListStyle())
    }

    var body: some View {
        NavigationView {
            #if os(macOS)
            sidebar.frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
            #else
            sidebar
                .onOpenURL(perform: openURL)
            #endif

            switch selection {
            case .home:
                HomeView()

            case .search:
                SearchView()

            case .favourites:
                FavouritesView()

            case .watchList:
                WatchListView()

            case .trendingMovies:
                TrendingMoviesView()

            case .discoverMovies:
                DiscoverMoviesView()

            case .trendingTVShows:
                TrendingTVShowsView()

            case .discoverTVShows:
                DiscoverTVShowsView()

            case .none:
                Text("")
            }

        }
    }

}

extension AppSidebarNavigation {

    private func openURL(url: URL) {
        guard
            url.isDeeplink,
            let item = NavigationItem(deepLink: url)
        else {
            return
        }

        selection = item
    }

}

extension AppSidebarNavigation {

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

}

struct AppSidebarNavigation_Previews: PreviewProvider {

    static var previews: some View {
        AppSidebarNavigation()
    }

}
