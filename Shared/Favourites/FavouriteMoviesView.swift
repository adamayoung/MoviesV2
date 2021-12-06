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
            .animation(.default, value: movies)
            .navigationTitle("Favourite Movies")
    }

}

struct FavouriteMoviesView_Previews: PreviewProvider {

    static var previews: some View {
        FavouriteMoviesView()
    }

}
