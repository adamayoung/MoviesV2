//
//  AddFavouriteOverlay.swift
//  Movies
//
//  Created by Adam Young on 02/09/2020.
//

import SwiftUI

struct AddFavouriteOverlay: View {

    var isAvailable: Bool

    var body: some View {
        VStack(spacing: 8) {
            Text("Add a Favourite")
                .font(.headline)

            if isAvailable {
                Text("Favourites are synced across all your devices")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                Text("You need to be signed into iCloud to use Favourites")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top)
            }
        }
        .multilineTextAlignment(.center)
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
                AddFavouriteOverlay(isAvailable: false)
            })
        }
        .navigationTitle("Favourites")
    }

}
