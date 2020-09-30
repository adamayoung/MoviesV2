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
                MoviesCarousel(movies: trendingMovies, imageType: .backdrop(displaySize: .large))
                    .listRowInsets(EdgeInsets())
                    .accessibility(label: Text("Trending Movies Carousel"))
                    .accessibility(identifier: "TrendingMoviesCarousel")
            }

            Section(header: discoverMoviesSectionHeader) {
                MoviesCarousel(movies: discoverMovies, imageType: .poster(displaySize: .medium))
                    .listRowInsets(EdgeInsets())
                    .accessibility(label: Text("Discover Movies Carousel"))
                    .accessibility(identifier: "Discover Movies Carousel")
            }

            Section(header: trendingTVShowsSectionHeader) {
                TVShowsCarousel(tvShows: trendingTVShows, imageType: .backdrop(displaySize: .large))
                    .listRowInsets(EdgeInsets())
                    .accessibility(label: Text("Trending TV Shows Carousel"))
                    .accessibility(identifier: "TrendingTVShowsCarousel")
            }

            Section(header: discoverTVShowsSectionHeader) {
                TVShowsCarousel(tvShows: discoverTVShows, imageType: .poster(displaySize: .medium))
                    .listRowInsets(EdgeInsets())
                    .accessibility(label: Text("Discover TV Shows Carousel"))
                    .accessibility(identifier: "DiscoverTVShowsCarousel")
            }

            Section(header: trendingPeopleSectionHeader) {
                PeopleCarousel(people: trendingPeople, displaySize: .medium)
                    .listRowInsets(EdgeInsets())
                    .accessibility(label: Text("Trending People Carousel"))
                    .accessibility(identifier: "TrendingPeopleCarousel")
            }
        }
    }

    private var trendingMoviesSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Trending Movies")
                .font(.title)
                .fontWeight(.heavy)

            if !trendingMovies.isEmpty {
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
                .accessibility(label: Text("See more Trending Movies"))
                .accessibility(identifier: "SeeMoreTrendingMovies")
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

            if !discoverMovies.isEmpty {
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
                .accessibility(label: Text("See more Discover Movies"))
                .accessibility(identifier: "SeeMoreDiscoverMovies")
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


            if !trendingTVShows.isEmpty {
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
                .accessibility(label: Text("See more Trending TV Shows"))
                .accessibility(identifier: "SeeMoreTrendingTVShows")
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

            if !discoverTVShows.isEmpty {
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
                .accessibility(label: Text("See more Discover TV Shows"))
                .accessibility(identifier: "SeeMoreDiscoverTVShows")
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

            if !trendingPeople.isEmpty {
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
                .accessibility(label: Text("See more Trending People"))
                .accessibility(identifier: "SeeMoreTrendingPeople")
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
