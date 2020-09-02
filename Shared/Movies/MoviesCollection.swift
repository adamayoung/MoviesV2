//
//  MoviesCollection.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct MoviesCollection: View {

    var movies: [MovieListItem]
    var movieDidAppear: ((MovieListItem, Int) -> Void)?

    private var offset: Int {
        #if !os(watchOS)
        return 9
        #else
        return 15
        #endif
    }

    var body: some View {
        #if os(iOS)
        MoviesGrid(movies: movies, movieDidAppear: collectionMovieDidAppear)
        #else
        MoviesList(movies: movies, movieDidAppear: collectionMovieDidAppear)
        #endif
    }

    private func collectionMovieDidAppear(currentMovie movie: MovieListItem) {
        movieDidAppear?(movie, offset)
    }

}

struct MoviesCollection_Previews: PreviewProvider {

    static var previews: some View {
        MoviesCollection(movies: [])
    }

}
