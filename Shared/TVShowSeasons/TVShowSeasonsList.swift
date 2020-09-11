//
//  TVShowSeasonsList.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import SwiftUI

struct TVShowSeasonsList: View {

    var tvShowID: TVShow.ID
    var seasons: [TVShowSeason]

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
        List(seasons) { season in
            NavigationLink(destination: TVShowSeasonDetailsView(tvShowID: tvShowID, seasonNumber: season.seasonNumber)) {
                TVShowSeasonRow(season: season)
            }
        }
    }

}

struct TVShowSeasonsList_Previews: PreviewProvider {

    static var previews: some View {
        TVShowSeasonsList(tvShowID: 1, seasons: [])
    }

}
