//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MovieDetailsView: View {

    var id: Movie.ID

    @EnvironmentObject private var movieStore: MovieStore
    @EnvironmentObject private var cloudKitAvailability: CloudKitAvailability

    private var movie: Movie? {
        movieStore.movie(withID: id)
    }

    private var isFavourite: Bool {
        guard let movie = movie else {
            return false
        }

        return movieStore.isFavourite(movieID: movie.id)
    }

    private var credits: Credits? {
        movieStore.credits(forMovie: id)
    }

    private var recommendations: [Movie]? {
        movieStore.recommendations(forMovie: id)
    }

    private var title: String {
        movie?.title ?? ""
    }

    var body: some View {
        container
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if movie != nil {
                        Button(action: {
                            toogleFavourite()
                        }, label: {
                            favouriteButtonLabel
                        })
                        .disabled(!cloudKitAvailability.isAvailable)
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

    private var favouriteButtonLabel: some View {
        let imageName = isFavourite ? "heart.fill" : "heart"

        #if !os(watchOS)
        return Image(systemName: imageName)
        #else
        let title = isFavourite ? "Remove Favourite" : "Add Favourite"
        return Label(title, systemImage: imageName)
        #endif
    }

    private func toogleFavourite() {
        guard cloudKitAvailability.isAvailable else {
            return
        }

        guard let movie = movie else {
            return
        }

        movieStore.toggleFavourite(movie: movie)
    }

}

extension MovieDetailsView {

    private func fetch() {
        movieStore.fetchMovie(withID: id)
        movieStore.fetchCredits(forMovie: id)
        movieStore.fetchRecommendations(forMovie: id)
    }

}

struct MovieDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        MovieDetailsView(id: 1)
    }

}
