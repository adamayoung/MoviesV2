//
//  FavouritesView.swift
//  Movies
//
//  Created by Adam Young on 02/09/2020.
//

import SwiftUI

struct FavouritesView: View {

    @EnvironmentObject private var store: AppStore

    private var movies: [MovieListItem] {
        store.state.movies.topFavourites
    }

    private var hasFavourites: Bool {
        !movies.isEmpty
    }

    var body: some View {
        content
            .overlay(Group {
                if !hasFavourites {
                    VStack {
                        Text("Add a Favourite")
                            .font(.headline)
                            .multilineTextAlignment(.center)

                        Text("Favourites are synced across all your devices")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
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
