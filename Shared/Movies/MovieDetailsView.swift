//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MovieDetailsView: View {

    var id: Movie.ID

    @EnvironmentObject private var store: AppStore

    private var movie: Movie? {
        store.state.movies.movies[id]
    }

    private var isFavourite: Bool {
        guard let movie = movie else {
            return false
        }

        return store.state.movies.isFavourite(movie.id)
    }

    private var credits: Credits? {
        store.state.movies.credits[id]
    }

    private var recommendations: [MovieListItem]? {
        store.state.movies.recommendations[id]
    }

    private var title: String {
        movie?.title ?? ""
    }

    var body: some View {
        container
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if movie != nil {
                        Button {
                            toogleFavourite()
                        } label: {
                            Image(systemName: isFavourite ? "heart.fill" : "heart" )
                        }
                    }
                }
            }
            .onAppear(perform: fetch)
            .navigationTitle(title)
    }

    @ViewBuilder private var container: some View {
        #if os(iOS)
        content
            .navigationBarTitleDisplayMode(.inline)
        #elseif os(macOS)
        content
            .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
        if let movie = self.movie,
           let credits = self.credits,
           let recommendations = self.recommendations {
            MovieDetails(movie: movie, credits: credits, recommendations: recommendations)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

    private func toogleFavourite() {
        let isFavourite = !self.isFavourite

        if isFavourite {
            store.send(.movies(.addFavourite(movieID: id)))
        } else {
            store.send(.movies(.removeFavourite(movieID: id)))
        }
    }

}

extension MovieDetailsView {

    private func fetch() {
        guard movie == nil else {
            return
        }

        store.send(.movies(.fetchMovieExtended(id: id)))
    }

}

struct MovieDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        MovieDetailsView(id: 1)
    }

}
