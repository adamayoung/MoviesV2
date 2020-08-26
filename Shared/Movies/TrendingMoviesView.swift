//
//  TrendingMoviesView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TrendingMoviesView: View {

    @EnvironmentObject private var store: AppStore

    private var movies: [MovieListItem] {
        store.state.movies.trending
    }

    var body: some View {
        MoviesList(movies: movies, movieDidAppear: movieDidAppear)
            .onAppear(perform: fetch)
            .navigationTitle("Trending Movies")
    }

}

extension TrendingMoviesView {

    private func fetch() {
        guard movies.isEmpty else {
            return
        }

        store.send(.movies(.fetchTrending))
    }

    private func movieDidAppear(currentMovie movie: MovieListItem) {
        //store.fetchNextTrendingPageIfNeeded(currentMovie: movie)
    }

}

//struct TrendingMoviesView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TrendingMoviesView()
//    }
//
//}
