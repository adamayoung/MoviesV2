//
//  MoviesList.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MoviesList: View {

    var movies: [MovieListItem]
    var movieDidAppear: ((MovieListItem.ID) -> Void)?

    var body: some View {
        List {
            MovieRows(movies: movies, movieDidAppear: movieDidAppear)
        }
        .overlay(Group {
            if movies.isEmpty {
                ProgressView("Hang in there...")
            }
        })
    }

}

struct MoviesList_Previews: PreviewProvider {

    static var previews: some View {
        MoviesList(movies: [], movieDidAppear: { _ in })
    }

}
