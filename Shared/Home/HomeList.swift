//
//  HomeList.swift
//  Movies
//
//  Created by Adam Young on 18/08/2020.
//

import SwiftUI

struct HomeList: View {

    var trendingMovies: [Movie] = []
    var discoverMovies: [Movie] = []
    var trendingTVShows: [TVShow] = []
    var discoverTVShows: [TVShow] = []
    var trendingPeople: [Person] = []
    @Binding var navigationSelection: NavigationSelection?

    @State private var trendingMovieSelection: Movie.ID?
    @State private var discoverMovieSelection: Movie.ID?

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

    @State private var selection: Movie?

    var body: some View {
        #if os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
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
            NavigationLink(
                destination: TrendingMoviesView(),
                tag: .trendingMovies,
                selection: $navigationSelection
            ) {
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
                .foregroundColor(.primary)

            Spacer()
            NavigationLink(
                destination: DiscoverMoviesView(),
                tag: .discoverMovies,
                selection: $navigationSelection
            ) {
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
            NavigationLink(
                destination: TrendingTVShowsView(),
                tag: .trendingTVShows,
                selection: $navigationSelection
            ) {
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
                .foregroundColor(.primary)

            Spacer()
            NavigationLink(
                destination: DiscoverTVShowsView(),
                tag: .discoverTVShows,
                selection: $navigationSelection
            ) {
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
            NavigationLink(
                destination: TrendingPeopleView(),
                tag: .trendingPeople,
                selection: $navigationSelection
            ) {
                Text("See more")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

}

extension HomeList {

    enum NavigationSelection: Hashable {
        case trendingMovies
        case discoverMovies
        case trendingTVShows
        case discoverTVShows
        case trendingPeople

        // swiftlint:disable cyclomatic_complexity
        init?(deepLink url: URL) {
            switch url.host {
            case "movies":
                switch url.path {
                case "/trending":
                    self = .trendingMovies

                case "/discover":
                    self = .discoverMovies

                default:
                    return nil
                }

            case "tvshows":
                switch url.path {
                case "/trending":
                    self = .trendingTVShows

                case "/discover":
                    self = .discoverTVShows

                default:
                    return nil
                }

            case "people":
                switch url.path {
                case "/trending":
                    self = .trendingPeople

                default:
                    return nil
                }

            default:
                return nil
            }
        }
        // swiftlint:enable cyclomatic_complexity
    }

}

struct HomeList_Previews: PreviewProvider {

    static var previews: some View {
        HomeList(navigationSelection: .constant(nil))
    }

}
