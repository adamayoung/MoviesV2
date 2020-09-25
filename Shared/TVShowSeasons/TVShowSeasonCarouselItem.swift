//
//  TVShowSeasonCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 11/09/2020.
//

import SwiftUI

struct TVShowSeasonCarouselItem: View {

    var tvShowID: TVShow.ID
    var season: TVShowSeason?
    var displaySize: PosterImage.DisplaySize = .medium

    @State private var isDetailActive = false

    var body: some View {
        VStack(alignment: .center) {
            if let season = season {
                NavigationLink(destination: TVShowSeasonDetailsView(tvShowID: tvShowID, seasonNumber: season.seasonNumber), isActive: self.$isDetailActive) {
                    EmptyView()
                }
            }

            PosterImage(imageMetadata: season?.posterImage, displaySize: displaySize)
                .shadow(radius: 8)

            Group {
                Text(season?.name ?? " \n ")
                    .fontWeight(displaySize == .large ? .heavy : .bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(label: Text(season?.name ?? ""))

                if let airDate = season?.airDate {
                    Text("\(airDate, formatter: DateFormatter.year)")
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibility(label: Text("\(airDate, formatter: DateFormatter.year)"))
                }
            }
            .font(displaySize == .large ? .headline : .subheadline)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            //.frame(width: displaySize.size.width * 1.25, alignment: .center)

            Spacer()
        }
        .onTapGesture {
            self.isDetailActive = true
        }
        .accessibilityElement(children: .combine)
    }
}

//struct TVShowSeasonCarouselItem_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowSeasonCarouselItem()
//    }
//}
