//
//  TVShowSeasonRow.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import SwiftUI

struct TVShowSeasonRow: View {

    var season: TVShowSeason

    private var verticalRowPadding: CGFloat {
        #if os(macOS)
        return 10
        #else
        return 0
        #endif
    }

    var body: some View {
        HStack(alignment: .center) {
            PosterImage(url: season.posterURL, displaySize: .medium)

            VStack(alignment: .leading) {
                Text(season.name)
                    .font(.headline)

                if let airDate = season.airDate {
                    Text("\(airDate, formatter: DateFormatter.year)")
                        .foregroundColor(.secondary)
                }
            }
        }
        .font(.subheadline)
        .padding(.vertical, verticalRowPadding)
        .accessibilityElement(children: .combine)
    }

}

//struct TVShowSeasonRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowSeasonRow()
//    }
//}
