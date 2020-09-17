//
//  FavouriteTVShowsView.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import SwiftUI

struct FavouriteTVShowsView: View {

    @EnvironmentObject private var tvShowStore: TVShowStore
    @State private var allowAnimations = false

    private var tvShows: [TVShow] {
        tvShowStore.favourites
    }

    var body: some View {
        TVShowsCollection(tvShows: tvShows)
            .overlay(Group {
                if tvShows.isEmpty {
                    AddFavouriteOverlay()
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
