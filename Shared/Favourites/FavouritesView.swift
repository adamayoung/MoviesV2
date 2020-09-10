//
//  FavouritesView.swift
//  Movies
//
//  Created by Adam Young on 02/09/2020.
//

import SwiftUI

struct FavouritesView: View {

    @EnvironmentObject private var store: AppStore

    private var movies: [Movie] {
        store.state.movies.topFavourites
    }

    private var hasFavourites: Bool {
        !movies.isEmpty
    }

    var body: some View {
        content
            .overlay(Group {
                if !hasFavourites {
                    AddFavouriteOverlay()
                }
            })
            .navigationTitle("Favourites")
    }

    @ViewBuilder private var content: some View {
        Group {
            if hasFavourites {
                FavouritesList(movies: movies)
            } else {
                List { }
            }
        }
    }

}

struct FavouritesView_Previews: PreviewProvider {

    static var previews: some View {
        FavouritesView()
    }

}
