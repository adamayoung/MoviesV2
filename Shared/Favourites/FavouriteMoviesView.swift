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

    private var movies: [MovieListItem] {
        store.state.movies.favourites
    }

    var body: some View {
        MoviesCollection(movies: movies)
            .overlay(Group {
                if movies.isEmpty {
                    VStack {
                        Text("Add a Favourite")
                            .font(.headline)

                        Text("Favourites are synced across all your devices")
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 50)
                    .padding(.horizontal, 50)
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
