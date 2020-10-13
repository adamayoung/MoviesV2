//
//  MediaCollection.swift
//  Movies
//
//  Created by Adam Young on 13/10/2020.
//

import SwiftUI

struct MediaCollection: View {

    @Binding var searchText: String
    var media: [Media]
    var mediaItemDidAppear: ((Media, Int) -> Void)?

    private var offset: Int {
        #if !os(watchOS)
        return 9
        #else
        return 15
        #endif
    }

    var body: some View {
        #if !os(watchOS)
        MediaGrid(searchText: $searchText, media: media, mediaItemDidAppear: collectionMediaItemDidAppear)
        #else
        MediaList(searchText: $searchText, media: media, mediaItemDidAppear: collectionMediaItemDidAppear)
        #endif
    }

    private func collectionMediaItemDidAppear(currentMediaItem mediaItem: Media) {
        mediaItemDidAppear?(mediaItem, offset)
    }

}

struct MediaCollection_Previews: PreviewProvider {
    static var previews: some View {
        MediaCollection(searchText: .constant("terminator"), media: [])
    }
}
