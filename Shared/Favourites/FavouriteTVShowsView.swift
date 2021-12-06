//
//  FavouriteTVShowsView.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import SwiftUI

struct FavouriteTVShowsView: View {

    @EnvironmentObject private var tvShowStore: TVShowStore
    @EnvironmentObject private var cloudKitAvailability: CloudKitAvailability

    private var tvShows: [TVShow] {
        tvShowStore.favourites
    }

    private var isFavouritesAvailable: Bool {
        cloudKitAvailability.isAvailable
    }

    var body: some View {
        TVShowsCollection(tvShows: tvShows)
            .overlay(Group {
                if tvShows.isEmpty {
                    AddFavouriteOverlay(isAvailable: isFavouritesAvailable)
                }
            })
            .animation(.default, value: tvShows)
            .navigationTitle("Favourite TV Shows")
    }

}

struct FavouriteTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        FavouriteTVShowsView()
    }

}
