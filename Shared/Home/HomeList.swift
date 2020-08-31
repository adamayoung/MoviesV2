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
    var trendingPeople: [PersonListItem] = []

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    private var largeBackdropDisplaySize: BackdropImage.DisplaySize {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return .large
        } else {
            return .extraLarge
        }
        #else
        return .large
        #endif
    }

    private var mediumBackdropDisplaySize: BackdropImage.DisplaySize {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return .medium
        } else {
            return .large
        }
        #else
        return .medium
        #endif
    }

    private var personDisplaySize: PersonImage.DisplaySize {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return .large
        } else {
            return .extraLarge
        }
        #else
        return .medium
        #endif
    }

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
                MoviesCarousel(movies: trendingMovies, displaySize: largeBackdropDisplaySize)
                    .listRowInsets(EdgeInsets())
            }

            Section(header: discoverMoviesSectionHeader) {
                MoviesCarousel(movies: discoverMovies, displaySize: mediumBackdropDisplaySize)
                    .listRowInsets(EdgeInsets())
            }

            Section(header: trendingTVShowsSectionHeader) {
                TVShowsCarousel(tvShows: trendingTVShows, displaySize: largeBackdropDisplaySize)
                    .listRowInsets(EdgeInsets())
            }

            Section(header: discoverTVShowsSectionHeader) {
                TVShowsCarousel(tvShows: discoverTVShows, displaySize: mediumBackdropDisplaySize)
                    .listRowInsets(EdgeInsets())
            }

            Section(header: trendingPeopleSectionHeader) {
                PeopleCarousel(people: trendingPeople, displaySize: personDisplaySize)
                    .listRowInsets(EdgeInsets())
            }
        }
    }

    private var trendingMoviesSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Trending Movies")
                .font(.title)
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
                .font(.title2)
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
                .font(.title)
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
                .font(.title2)
                .fontWeight(.heavy)

            Spacer()
            NavigationLink(destination: DiscoverTVShowsView()) {
                Text("See more")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

    private var trendingPeopleSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Trending People")
                .font(.title)
                .fontWeight(.heavy)

            Spacer()
            NavigationLink(destination: TrendingPeopleView()) {
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
