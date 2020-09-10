//
//  FavouriteMoviesView.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct FavouriteMoviesView: View {

    @EnvironmentObject private var store: AppStore
    @State private var allowAnimations = false

    private var movies: [Movie] {
        store.state.movies.favourites
    }

    var body: some View {
        MoviesCollection(movies: movies)
            .overlay(Group {
                if movies.isEmpty {
                    AddFavouriteOverlay()
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
