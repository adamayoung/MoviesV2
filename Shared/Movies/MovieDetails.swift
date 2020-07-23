//
//  MovieDetails.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MovieDetails: View {

    #if os(iOS)
    private let listStyle = InsetGroupedListStyle()
    #else
    private let listStyle = DefaultListStyle()
    #endif

    private var topCast: [CastMember] {
        Array(credits.cast.prefix(10))
    }

    var movie: Movie
    var credits: Credits
    var recommendations: [MovieListItem]

    var body: some View {
        List {
            Section(header: header) {
                EmptyView()
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, -20)

            if let overview = movie.overview {
                #if !os(watchOS)
                Section {
                    ShowPlotRow(title: movie.title, text: overview)
                }
                #else
                ShowPlotRow(title: movie.title, text: overview)
                #endif
            }

            if !credits.isEmpty {
                #if !os(watchOS)
                Section(header: Text("Cast & Crew")) {
                    if !topCast.isEmpty {
                        CastCarousel(cast: topCast, displaySize: .medium)
                            .listRowInsets(EdgeInsets())
                    }

                    NavigationLink(destination: CreditsView(movieID: movie.id)) {
                        Text("All Cast & Crew")
                    }
                }
                #else
                NavigationLink(destination: CreditsView(movieID: movie.id)) {
                    HStack {
                        Spacer()
                        Text("Cast & Crew")
                        Spacer()
                    }
                }
                #endif
            }

            #if !os(watchOS)
            if !recommendations.isEmpty {
                Section(header: Text("Recommendations")) {
                    MoviesCarousel(movies: recommendations, displaySize: .medium)
                        .listRowInsets(EdgeInsets())
                }
            }
            #endif
        }
        .listStyle(listStyle)
    }

    private var header: some View {
        ShowDetailsHeader(movie: movie)
            .id("movie-overview-header-\(movie.id)")
    }

}

//struct MovieDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetails()
//    }
//}
