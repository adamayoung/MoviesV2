//
//  TVShowGridItem.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct TVShowGridItem: View {

    var tvShow: TVShow

    var body: some View {
        PosterImage(imageMetadata: tvShow.posterImage)
            .shadow(radius: 5)
    }

}

//struct TVShowGridItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TVShowGridItem()
//    }
//
//}
