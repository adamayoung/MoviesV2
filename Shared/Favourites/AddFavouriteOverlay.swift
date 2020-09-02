//
//  AddFavouriteOverlay.swift
//  Movies
//
//  Created by Adam Young on 02/09/2020.
//

import SwiftUI

struct AddFavouriteOverlay: View {
    var body: some View {
        VStack {
            Text("Add a Favourite")
                .font(.headline)
                .multilineTextAlignment(.center)

            Text("Favourites are synced across all your devices")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
    }
}

struct AddFavouriteOverlay_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            List {

            }
            .overlay(Group {
                AddFavouriteOverlay()
            })
        }
        .navigationTitle("Favourites")
    }

}
