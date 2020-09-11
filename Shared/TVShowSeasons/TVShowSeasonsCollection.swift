//
//  TVShowSeasonsCollection.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import SwiftUI

struct TVShowSeasonsCollection: View {

    var tvShowID: TVShow.ID
    var seasons: [TVShowSeason]

    var body: some View {
        #if !os(watchOS)
        TVShowSeasonsGrid(tvShowID: tvShowID, seasons: seasons)
        #else
        TVShowSeasonsList(tvShowID: tvShowID, seasons: seasons)
        #endif
    }

}

struct TVShowSeasonsCollection_Previews: PreviewProvider {

    static var previews: some View {
        TVShowSeasonsCollection(tvShowID: 1, seasons: [])
    }

}
