//
//  MoviesList.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MoviesList: View {

    var movies: [MovieListItem] = []
    var movieDidAppear: ((MovieListItem) -> Void)?

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #elseif os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    var content: some View {
        List(movies) { movie in
            NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                MovieRow(movie: movie)
                    .onAppear {
                        self.movieDidAppear?(movie)
                    }
            }
        }
    }

}

struct MoviesList_Previews: PreviewProvider {

    static var previews: some View {
        MoviesList()
    }

}
