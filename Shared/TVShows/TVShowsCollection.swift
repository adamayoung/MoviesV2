//
//  TVShowsCollection.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct TVShowsCollection: View {

    var tvShows: [TVShowListItem]
    var tvShowDidAppear: ((TVShowListItem, Int) -> Void)?

    private var offset: Int {
        #if !os(watchOS)
        return 9
        #else
        return 15
        #endif
    }

    var body: some View {
        #if !os(watchOS)
        TVShowsGrid(tvShows: tvShows, tvShowDidAppear: collectionTVShowDidAppear)
        #else
        TVShowsList(tvShows: tvShows, tvShowDidAppear: collectionTVShowDidAppear)
        #endif
    }

    private func collectionTVShowDidAppear(currentTVShow tvShow: TVShowListItem) {
        tvShowDidAppear?(tvShow, offset)
    }

}

struct TVShowsCollection_Previews: PreviewProvider {

    static var previews: some View {
        TVShowsCollection(tvShows: [])
    }

}
