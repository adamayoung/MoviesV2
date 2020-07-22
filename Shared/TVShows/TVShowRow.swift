//
//  TVShowRow.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct TVShowRow: View {

    private static let yearDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter
    }()

    var tvShow: TVShowListItem

    var body: some View {
        HStack(alignment: .center) {
            PosterImage(path: tvShow.posterPath, displaySize: .medium)

            VStack(alignment: .leading) {
                Text(tvShow.name)
                    .font(.headline)

                Group {
                    Text("TV Show")

                    if let firstAirDate = tvShow.firstAirDate {
                        Text("\(firstAirDate, formatter: Self.yearDateFormatter)")
                    } else {
                        Text("No first air date")
                    }
                }
                .foregroundColor(.gray)
                .font(.subheadline)
            }
        }
    }

}

struct TVShowRow_Previews: PreviewProvider {

    static var previews: some View {
        let tvShow = TVShowListItem(id: 1, name: "Thundercats")

        return List {
            TVShowRow(tvShow: tvShow)
        }
    }

}
