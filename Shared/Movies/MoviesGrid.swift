//
//  MoviesGrid.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct MoviesGrid: View {

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    var movies: [Movie] = []
    var favourites: [Movie.ID] = []
    var movieDidAppear: ((Movie) -> Void)?

    private let columnsCompact: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    private let columnsRegular: [GridItem] = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    private var columns: [GridItem] {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return columnsCompact
        } else {
            return columnsRegular
        }
        #else
        return columnsRegular
        #endif
    }

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #else
        content
        #endif
    }

    var content: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                        MovieGridItem(movie: movie)
                            .onAppear {
                                self.movieDidAppear?(movie)
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

}

struct MoviesGrid_Previews: PreviewProvider {

    static var previews: some View {
        MoviesGrid()
    }

}
