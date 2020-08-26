//
//  HomeList.swift
//  Movies
//
//  Created by Adam Young on 18/08/2020.
//

import SwiftUI

struct HomeList: View {

    var trendingMovies: [MovieListItem] = []
    var discoverMovies: [MovieListItem] = []
    var trendingTVShows: [TVShowListItem] = []
    var discoverTVShows: [TVShowListItem] = []

    @State private var selection: MovieListItem?

    var body: some View {
        #if os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List {
            Section(header: trendingMoviesSectionHeader) {
                MoviesCarousel(movies: trendingMovies, displaySize: .large)
                    .listRowInsets(EdgeInsets())
            }

            Section(header: discoverMoviesSectionHeader) {
                MoviesCarousel(movies: discoverMovies)
                    .listRowInsets(EdgeInsets())
            }

            Section(header: trendingTVShowsSectionHeader) {
                TVShowsCarousel(tvShows: trendingTVShows, displaySize: .large)
                    .listRowInsets(EdgeInsets())
            }

            Section(header: discoverTVShowsSectionHeader) {
                TVShowsCarousel(tvShows: discoverTVShows)
                    .listRowInsets(EdgeInsets())
            }
        }
    }

    private var trendingMoviesSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Trending Movies")
                .font(.title2)
                .fontWeight(.heavy)

            Spacer()
            NavigationLink(destination: TrendingMoviesView()) {
                Text("See more")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

    private var discoverMoviesSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Discover Movies")
                .font(.title3)
                .fontWeight(.heavy)

            Spacer()
            NavigationLink(destination: DiscoverMoviesView()) {
                Text("See more")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

    private var trendingTVShowsSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Trending TV Shows")
                .font(.title2)
                .fontWeight(.heavy)

            Spacer()
            NavigationLink(destination: TrendingTVShowsView()) {
                Text("See more")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

    private var discoverTVShowsSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Discover TV Shows")
                .font(.title3)
                .fontWeight(.heavy)

            Spacer()
            NavigationLink(destination: TrendingTVShowsView()) {
                Text("See more")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

}

struct HomeList_Previews: PreviewProvider {

    static var previews: some View {
        HomeList()
    }

}
