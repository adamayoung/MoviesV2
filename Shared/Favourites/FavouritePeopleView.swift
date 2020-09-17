//
//  FavouritePeopleView.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import SwiftUI

struct FavouritePeopleView: View {

    @EnvironmentObject private var personStore: PersonStore
    @State private var allowAnimations = false

    private var people: [Person] {
        personStore.favourites
    }

    var body: some View {
        PeopleCollection(people: people)
            .overlay(Group {
                if people.isEmpty {
                    AddFavouriteOverlay()
                }
            })
            .animation(self.allowAnimations ? .default : nil)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.allowAnimations = true
                }
            }
            .navigationTitle("Favourite People")
    }

}

struct FavouritePeopleView_Previews: PreviewProvider {

    static var previews: some View {
        FavouritePeopleView()
    }

}
