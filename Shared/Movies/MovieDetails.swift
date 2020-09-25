//
//  MovieDetails.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MovieDetails: View {

    var movie: Movie
    var credits: Credits
    var recommendations: [Movie]

    private var topCast: [CastMember] {
        Array(credits.cast.prefix(10))
    }

    var body: some View {
        #if os(iOS)
        content
            .listStyle(InsetGroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List {
            Section(header: MovieDetailsHeader(movie: movie)) {
                EmptyView()
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, -20)

            if let overview = movie.overview, !overview.isEmpty {
                #if !os(watchOS)
                Section {
                    ShowPlotRow(title: movie.title, plot: overview)
                }
                #else
                ShowPlotRow(title: movie.title, plot: overview)
                #endif
            }

            if !topCast.isEmpty {
                #if !os(watchOS)
                Section(header: castAndCrewSectionHeader) {
                    CastCarousel(cast: topCast, displaySize: .small)
                        .listRowInsets(EdgeInsets())
                }
                #else
                NavigationLink(destination: MovieCreditsView(movieID: movie.id)) {
                    HStack {
                        Spacer()
                        Text("Cast & Crew")
                        Spacer()
                    }
                }
                #endif
            }

            if !recommendations.isEmpty {
                #if !os(watchOS)
                Section(header: Text("Recommendations").listSectionHeaderStyle()) {
                    MoviesCarousel(movies: recommendations, imageType: .backdrop(displaySize: .small))
                        .listRowInsets(EdgeInsets())
                }
                #else
                NavigationLink(destination: RecommendedMoviesView(movieID: movie.id)) {
                    HStack {
                        Spacer()
                        Text("Recommendations")
                        Spacer()
                    }
                }
                #endif
            }
        }
    }

    private var castAndCrewSectionHeader: some View {
        HStack {
            Text("Top Cast")
                .listSectionHeaderStyle()
            Spacer()
            NavigationLink(destination: MovieCreditsView(movieID: movie.id)) {
                Text("See all")
                    .font(.body)
                    .foregroundColor(.accentColor)
                    .textCase(.none)
            }
        }
    }

}

struct MovieDetails_Previews: PreviewProvider {

    static var previews: some View {
        let movie = Movie(
            id: 1,
            title: "Fight Club",
            overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
            runtime: TimeInterval(120 * 60),
            genres: [
                Genre(id: 1, name: "Drama"),
                Genre(id: 2, name: "Action")
            ],
            releaseDate: Date(timeIntervalSinceNow: 0)
        )

        return NavigationView {
            MovieDetails(movie: movie, credits: Credits(), recommendations: [])
        }
    }

}
