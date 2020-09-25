//
//  FavouriteMoviesView.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct FavouriteMoviesView: View {

    @EnvironmentObject private var movieStore: MovieStore
    @EnvironmentObject private var cloudKitAvailability: CloudKitAvailability
    @State private var allowAnimations = false

    private var movies: [Movie] {
        movieStore.favourites
    }

    private var isFavouritesAvailable: Bool {
        cloudKitAvailability.isAvailable
    }

    var body: some View {
        MoviesCollection(movies: movies)
            .overlay(Group {
                if movies.isEmpty {
                    AddFavouriteOverlay(isAvailable: isFavouritesAvailable)
                }
            })
            .animation(self.allowAnimations ? .default : nil)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.allowAnimations = true
                }
            }
            .navigationTitle("Favourite Movies")
    }

}

struct FavouriteMoviesView_Previews: PreviewProvider {

    static var previews: some View {
        FavouriteMoviesView()
    }

}
