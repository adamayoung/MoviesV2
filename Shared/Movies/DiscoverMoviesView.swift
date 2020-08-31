//
//  DiscoverMoviesView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct DiscoverMoviesView: View {

    @EnvironmentObject private var store: AppStore

    private var movies: [MovieListItem] {
        store.state.movies.discover
    }

    var body: some View {
        MoviesCollection(movies: movies, movieDidAppear: movieDidAppear)
            .onAppear(perform: fetch)
            .navigationTitle("Discover Movies")
    }

}

extension DiscoverMoviesView {

    private func fetch() {
        guard movies.isEmpty else {
            return
        }

        store.send(.movies(.fetchDiscover))
    }

    private func movieDidAppear(currentMovie movie: MovieListItem, offset: Int) {
        store.send(.movies(.fetchNextDiscoverIfNeeded(currentMovie: movie, offset: offset)))
    }

}

//struct DiscoverMoviesView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        DiscoverMoviesView()
//    }
//
//}
