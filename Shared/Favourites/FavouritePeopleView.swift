//
//  FavouritePeopleView.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import SwiftUI

struct FavouritePeopleView: View {

    @EnvironmentObject private var personStore: PersonStore
    @EnvironmentObject private var cloudKitAvailability: CloudKitAvailability

    private var people: [Person] {
        personStore.favourites
    }

    private var isFavouritesAvailable: Bool {
        cloudKitAvailability.isAvailable
    }

    var body: some View {
        PeopleCollection(people: people)
            .overlay(Group {
                if people.isEmpty {
                    AddFavouriteOverlay(isAvailable: isFavouritesAvailable)
                }
            })
            .animation(.default, value: people)
            .navigationTitle("Favourite People")
    }

}

struct FavouritePeopleView_Previews: PreviewProvider {

    static var previews: some View {
        FavouritePeopleView()
    }

}
