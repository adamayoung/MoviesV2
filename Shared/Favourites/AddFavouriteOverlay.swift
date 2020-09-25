//
//  AddFavouriteOverlay.swift
//  Movies
//
//  Created by Adam Young on 02/09/2020.
//

import SwiftUI
import UIKit

struct AddFavouriteOverlay: View {

    var isAvailable: Bool

    var body: some View {
        VStack(spacing: 8) {
            Text("Add a Favourite")
                .font(.headline)
                .multilineTextAlignment(.center)

            Text("Favourites are synced across all your devices")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            if !isAvailable {
                Text("You need to be signed into iCloud to use Favourites")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }
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
                AddFavouriteOverlay(isAvailable: false)
            })
        }
        .navigationTitle("Favourites")
    }

}
