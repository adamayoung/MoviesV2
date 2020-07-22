//
//  HomeList.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct HomeList: View {

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    var trendingMovies: [MovieListItem] = []
    var discoverMovies: [MovieListItem] = []
    var trendingTVShows: [TVShowListItem] = []
    var discoverTVShows: [TVShowListItem] = []

    var body: some View {
        List {
            MoviesCarousel(header: "Trending Movies", movies: trendingMovies, displaySize: .large)
                .listRowInsets(EdgeInsets())
                .background(sectionBackground)

            #if os(iOS)
            if horizontalSizeClass == .compact {
                NavigationLink(destination: TrendingMoviesView()) {
                    Text("See all")
                        .foregroundColor(.accentColor)
                }
            }
            #endif

            MoviesCarousel(header: "Discover Movies", movies: discoverMovies)
                .listRowInsets(EdgeInsets())
                .background(sectionBackground)

            #if os(iOS)
            if horizontalSizeClass == .compact {
                NavigationLink(destination: DiscoverMoviesView()) {
                    Text("See all")
                        .foregroundColor(.accentColor)
                }
            }
            #endif

            TVShowsCarousel(header: "Trending TV Shows", tvShows: trendingTVShows, displaySize: .large)
                .listRowInsets(EdgeInsets())
                .background(sectionBackground)

            #if os(iOS)
            if horizontalSizeClass == .compact {
                NavigationLink(destination: TrendingTVShowsView()) {
                    Text("See all")
                        .foregroundColor(.accentColor)
                }
            }
            #endif

            TVShowsCarousel(header: "Discover TV Shows", tvShows: discoverTVShows)
                .listRowInsets(EdgeInsets())
                .background(sectionBackground)

            #if os(iOS)
            if horizontalSizeClass == .compact {
                NavigationLink(destination: DiscoverTVShowsView()) {
                    Text("See all")
                        .foregroundColor(.accentColor)
                }
            }
            #endif
        }
    }

}

extension HomeList {

    private var sectionBackground: some View {
        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear, Color.secondary.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
    }

}

struct HomeList_Previews: PreviewProvider {

    static var previews: some View {
        HomeList()
    }

}
