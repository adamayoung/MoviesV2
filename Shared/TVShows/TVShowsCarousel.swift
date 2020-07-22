//
//  TVShowsCarousel.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb

struct TVShowsCarousel: View {

    var header: String?
    var tvShows: [TVShowListItem]
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let header = header {
                Text("\(header)")
                    .font(displaySize == .large ? .title2 : .title3)
                    .fontWeight(.heavy)
                    .padding([.horizontal, .top])
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    if !tvShows.isEmpty {
                        ForEach(tvShows) { tvShow in
                            TVShowCarouselItem(tvShow: tvShow, displaySize: displaySize)
                        }
                    } else {
                        ForEach(0...10, id: \.self) { _ in
                            TVShowCarouselItem(displaySize: displaySize)
                        }
                    }
                }
                .padding(20)
            }
            .disabled(tvShows.isEmpty)
        }
    }

}

struct TVShowsCarousel_Previews: PreviewProvider {

    static var previews: some View {
        TVShowsCarousel(header: "TV Shows", tvShows: [])
    }

}
