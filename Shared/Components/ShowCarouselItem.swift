//
//  ShowCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct ShowCarouselItem: View {

    var show: ShowListItem?
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        switch show {
        case .movie(let movie):
            MovieCarouselItem(movie: movie, displaySize: displaySize)

        case .tvShow(let tvShow):
            TVShowCarouselItem(tvShow: tvShow, displaySize: displaySize)

        case .none:
            MovieCarouselItem(movie: nil, displaySize: displaySize)
        }
    }

}

struct ShowCarouselItem_Previews: PreviewProvider {

    static var previews: some View {
        ShowCarouselItem(show: nil)
    }

}
