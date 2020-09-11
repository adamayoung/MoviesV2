//
//  TVShowSeasonsCarousel.swift
//  Movies
//
//  Created by Adam Young on 11/09/2020.
//

import SwiftUI

struct TVShowSeasonsCarousel: View {

    var tvShowID: TVShow.ID
    var seasons: [TVShowSeason]
    var displaySize: PosterImage.DisplaySize = .medium

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if !seasons.isEmpty {
                    ForEach(seasons) { season in
                        TVShowSeasonCarouselItem(tvShowID: tvShowID, season: season, displaySize: displaySize)
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        TVShowSeasonCarouselItem(tvShowID: tvShowID, displaySize: displaySize)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .animation(.default)
        .disabled(seasons.isEmpty)
    }

}

struct TVShowSeasonsCarousel_Previews: PreviewProvider {

    static var previews: some View {
        TVShowSeasonsCarousel(tvShowID: 1, seasons: [])
    }

}
