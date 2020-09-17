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
                        Label(title: {
                            Text("Search")
                        }, icon: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.accentColor)
                        })
                    }
                    .accessibility(label: Text("Search"))
                }

                Section(header: Text("Movies")) {
                    NavigationLink(
                        destination: TrendingMoviesView(),
                        tag: NavigationItem.trendingMovies,
                        selection: $selection) {
                        Label(title: {
                            Text("Trending")
                        }, icon: {
                            Image(systemName: "film")
                                .foregroundColor(.accentColor)
                        })
                    }
                    .accessibility(label: Text("Trending Movies"))

                    NavigationLink(
                        destination: DiscoverMoviesView(),
                        tag: NavigationItem.discoverMovies,
                        selection: $selection) {
                        Label(title: {
                            Text("Discover")
                        }, icon: {
                            Image(systemName: "film.fill")
                                .foregroundColor(.accentColor)
                        })
                    }
                    .accessibility(label: Text("Discover Movies"))

                    NavigationLink(
                        destination: FavouriteMoviesView(),
                        tag: NavigationItem.favouriteMovies,
                        selection: $selection) {
                        Label(title: {
                            Text("Favourites")
                        }, icon: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.accentColor)
                        })

                    }
                    .accessibility(label: Text("Favourite Movies"))
                }

                Section(header: Text("TV Shows")) {
                    NavigationLink(
                        destination: TrendingTVShowsView(),
                        tag: NavigationItem.trendingTVShows,
                        selection: $selection) {
                        Label(title: {
                            Text("Trending")
                        }, icon: {
                            Image(systemName: "tv")
                                .foregroundColor(.accentColor)
                        })
                    }
                    .accessibility(label: Text("Trending TV Shows"))

                    NavigationLink(
                        destination: DiscoverTVShowsView(),
                        tag: NavigationItem.discoverTVShows,
                        selection: $selection) {
                        Label(title: {
                            Text("Discover")
                        }, icon: {
                            Image(systemName: "tv.fill")
                                .foregroundColor(.accentColor)
                        })
                    }
                    .accessibility(label: Text("Discover TV Shows"))

                    NavigationLink(
                        destination: FavouriteTVShowsView(),
                        tag: NavigationItem.favouriteTVShows,
                        selection: $selection) {
                        Label(title: {
                            Text("Favourites")
                        }, icon: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.accentColor)
                        })

                    }
                    .accessibility(label: Text("Favourite TV Shows"))
                }

                Section(header: Text("People")) {
                    NavigationLink(
                        destination: TrendingPeopleView(),
                        tag: NavigationItem.trendingPeople,
                        selection: $selection) {
                        Label(title: {
                            Text("Trending")
                        }, icon: {
                            Image(systemName: "person.2")
                                .foregroundColor(.accentColor)
                        })

                    }
                    .accessibility(label: Text("Trending People"))

                    NavigationLink(
                        destination: FavouritePeopleView(),
                        tag: NavigationItem.favouritePeople,
                        selection: $selection) {
                        Label(title: {
                            Text("Favourites")
                        }, icon: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.accentColor)
                        })

                    }
                    .accessibility(label: Text("Favourite People"))
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
        case search
        case trendingMovies
        case discoverMovies
        case favouriteMovies
        case trendingTVShows
        case discoverTVShows
        case favouriteTVShows
        case trendingPeople
        case favouritePeople
    }

}

struct AppWatchNavigation_Previews: PreviewProvider {

    static var previews: some View {
        AppWatchNavigation()
    }

}
