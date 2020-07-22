//
//  MovieRows.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct MovieRows: View {

    var movies: [MovieListItem]
    var movieDidAppear: ((MovieListItem.ID) -> Void)?

    var body: some View {
        ForEach(movies) { movie in
            NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                MovieRow(movie: movie)
                    .onAppear {
                        self.movieDidAppear?(movie.id)
                    }
            }
        }
    }

}

struct MovieRows_Previews: PreviewProvider {

    static var previews: some View {
        MovieRows(movies: [])
    }

}
