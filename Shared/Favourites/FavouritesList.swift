//
//  FavouritesList.swift
//  Movies
//
//  Created by Adam Young on 02/09/2020.
//

import SwiftUI

struct FavouritesList: View {

    var movies: [MovieListItem]

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    private var largeBackdropDisplaySize: BackdropImage.DisplaySize {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return .large
        } else {
            return .extraLarge
        }
        #else
        return .large
        #endif
    }

    var body: some View {
        #if os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List {
            Section(header: moviesSectionHeader) {
                MoviesCarousel(movies: movies, displaySize: largeBackdropDisplaySize)
                    .listRowInsets(EdgeInsets())
            }
        }
    }

    private var moviesSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Movies")
                .font(.title)
                .fontWeight(.heavy)

            Spacer()
            NavigationLink(destination: FavouriteMoviesView()) {
                Text("See all")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

}

struct FavouritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesList(movies: [])
    }
}