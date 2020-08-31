//
//  RecommendedMoviesView.swift
//  Movies
//
//  Created by Adam Young on 24/07/2020.
//

import SwiftUI

struct RecommendedMoviesView: View {

    var movieID: Movie.ID

    @EnvironmentObject private var store: AppStore

    private var movies: [MovieListItem]? {
        store.state.movies.recommendations[movieID]
    }

    var body: some View {
        content
            .onAppear(perform: fetch)
            .navigationTitle("Recommendations")
    }

    @ViewBuilder private var content: some View {
        if let movies = movies {
            MoviesCollection(movies: movies)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension RecommendedMoviesView {

    private func fetch() {
        guard movies == nil else {
            return
        }

        store.send(.movies(.fetchRecommendations(movieID: movieID)))
    }

}

//struct RecommendedMoviesView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        RecommendedMoviesView(movieID: 1)
//    }
//
//}
