//
//  ShowCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct ShowCarouselItem: View {

    var show: Show?
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        switch show {
        case .movie(let movie):
            MovieCarouselItem(movie: movie, imageType: .backdrop(displaySize: displaySize))

        case .tvShow(let tvShow):
            TVShowCarouselItem(tvShow: tvShow, imageType: .backdrop(displaySize: displaySize))

        case .none:
            MovieCarouselItem(movie: nil, imageType: .backdrop(displaySize: displaySize))
        }
    }

}

struct ShowCarouselItem_Previews: PreviewProvider {

    static var previews: some View {
        ShowCarouselItem(show: nil)
    }

}
