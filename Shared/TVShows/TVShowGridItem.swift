//
//  TVShowGridItem.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct TVShowGridItem: View {

    var tvShow: TVShowListItem

    var body: some View {
        PosterImage(url: tvShow.posterURL)
    }

}

//struct TVShowGridItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TVShowGridItem()
//    }
//
//}