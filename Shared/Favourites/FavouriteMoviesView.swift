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

    private var favourites: [MovieListItem] {
        store.state.movies.favourites
    }

    var body: some View {
        MoviesCollection(movies: favourites)
            .overlay(Group {
                if favourites.isEmpty {
                    Text("Add a Favourite")
                }
            })
            .animation(self.allowAnimations ? .default : nil)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.allowAnimations = true
                }
            }
            .navigationTitle("Favourites")
    }

}

struct FavouriteMoviesView_Previews: PreviewProvider {

    static var previews: some View {
        FavouriteMoviesView()
    }

}
