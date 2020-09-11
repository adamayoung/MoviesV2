//
//  TVShowRow.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct TVShowRow: View {

    var tvShow: TVShow

    private var verticalRowPadding: CGFloat {
        #if os(macOS)
        return 10
        #else
        return 0
        #endif
    }

    var body: some View {
        HStack(alignment: .center) {
            PosterImage(url: tvShow.posterURL, displaySize: .medium)

            VStack(alignment: .leading) {
                Text(tvShow.name)
                    .font(.headline)

                Group {
                    Text("TV Show")

                    if let firstAirDate = tvShow.firstAirDate {
                        Text("\(firstAirDate, formatter: DateFormatter.year)")
                    } else {
                        Text("No first air date")
                    }
                }
                .foregroundColor(.secondary)
            }
        }
        .font(.subheadline)
        .padding(.vertical, verticalRowPadding)
        .accessibilityElement(children: .combine)
    }

}

struct TVShowRow_Previews: PreviewProvider {

    static var previews: some View {
        let tvShow = TVShow(id: 1, name: "Thundercats")

        return List {
            TVShowRow(tvShow: tvShow)
        }
    }

}
