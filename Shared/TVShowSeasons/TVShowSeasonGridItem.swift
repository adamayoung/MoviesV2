//
//  TVShowSeasonGridItem.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import SwiftUI

struct TVShowSeasonGridItem: View {

    var season: TVShowSeason

    var body: some View {
        VStack {
            PosterImage(url: season.posterURL)

            Text(season.name)
                .foregroundColor(.primary)

            if let airDate = season.airDate {
                Text("\(airDate, formatter: DateFormatter.year)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
        .accessibilityElement(children: .combine)
    }

}

//struct TVShowSeasonGridItem_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowSeasonGridItem()
//    }
//}
