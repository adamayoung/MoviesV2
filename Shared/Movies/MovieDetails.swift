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
            Section(header: ShowDetailsHeader(movie: movie)) {
                EmptyView()
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, -20)

            if let overview = movie.overview {
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
                    CastCarousel(cast: topCast, displaySize: .medium)
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
                Section(header: Text("Recommendations")) {
                    MoviesCarousel(movies: recommendations, displaySize: .medium)
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

//struct MovieDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetails()
//    }
//}
