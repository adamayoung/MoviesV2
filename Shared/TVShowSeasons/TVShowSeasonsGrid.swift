//
//  TVShowSeasonsGrid.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import SwiftUI

struct TVShowSeasonsGrid: View {

    var tvShowID: TVShow.ID
    var seasons: [TVShowSeason]

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    private let columnsCompact: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    private let columnsRegular: [GridItem] = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    private var columns: [GridItem] {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return columnsCompact
        } else {
            return columnsRegular
        }
        #else
        return columnsRegular
        #endif
    }

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #elseif os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    var content: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                ForEach(seasons) { season in
                    NavigationLink(destination: TVShowSeasonDetailsView(tvShowID: tvShowID, seasonNumber: season.seasonNumber)) {
                        TVShowSeasonGridItem(season: season)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

}

struct TVShowSeasonsGrid_Previews: PreviewProvider {

    static var previews: some View {
        TVShowSeasonsGrid(tvShowID: 1, seasons: [])
    }

}
