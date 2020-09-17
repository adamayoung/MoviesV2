//
//  FavouritesView.swift
//  Movies
//
//  Created by Adam Young on 02/09/2020.
//

import SwiftUI

struct FavouritesView: View {

    @EnvironmentObject private var movieStore: MovieStore
    @EnvironmentObject private var tvShowStore: TVShowStore
    @EnvironmentObject private var personStore: PersonStore

    private var movies: [Movie] {
        movieStore.topFavourites
    }

    private var tvShows: [TVShow] {
        tvShowStore.topFavourites
    }

    private var people: [Person] {
        personStore.topFavourites
    }

    private var hasFavourites: Bool {
        !movies.isEmpty || !tvShows.isEmpty || !people.isEmpty
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
                FavouritesList(movies: movies, tvShows: tvShows, people: people)
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
