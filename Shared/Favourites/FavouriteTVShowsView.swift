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
    @State private var allowAnimations = false

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
            .animation(self.allowAnimations ? .default : nil)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.allowAnimations = true
                }
            }
            .navigationTitle("Favourite TV Shows")
    }

}

struct FavouriteTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        FavouriteTVShowsView()
    }

}
