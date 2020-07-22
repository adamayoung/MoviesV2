//
//  FavouritesView.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct FavouritesView: View {

    var body: some View {
        List {
            Text("Favourites")
        }
        .navigationTitle("Favourites")
    }

}

struct FavouritesView_Previews: PreviewProvider {

    static var previews: some View {
        FavouritesView()
    }

}
