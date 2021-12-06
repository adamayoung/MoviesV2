//
//  TVShowsCarousel.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TVShowsCarousel: View {

    var tvShows: [TVShow]
    var imageType: TVShowCarouselItem.ImageType = .backdrop(displaySize: .medium)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if !tvShows.isEmpty {
                    ForEach(tvShows) { tvShow in
                        TVShowCarouselItem(tvShow: tvShow, imageType: imageType)
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        TVShowCarouselItem(imageType: imageType)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .animation(.default, value: tvShows)
        .disabled(tvShows.isEmpty)
    }

}

struct TVShowsCarousel_Previews: PreviewProvider {

    static var previews: some View {
        TVShowsCarousel(tvShows: [])
    }

}
