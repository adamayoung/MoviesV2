//
//  TVShowDetailsHeader.swift
//  Movies
//
//  Created by Adam Young on 16/09/2020.
//

import SwiftUI

struct TVShowDetailsHeader: View {

    var tvShow: TVShow

    private var metadataItems: [String] {
        var items = [String]()
        if let genre = tvShow.genres?.first {
            items.append(genre.name)
        }

        if let releaseDate = tvShow.firstAirDate {
            items.append(DateFormatter.year.string(from: releaseDate))
        }

        return items
    }

    var body: some View {
        VStack {
            ShowDetailsHeader(tvShow: tvShow)

            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    Text("\(metadataItems.joined(separator: " ・ "))")
                    Spacer()
                }

                if let voteAverage = tvShow.voteAverage {
                    VoteLabel(voteAverage: voteAverage)
                }
            }
            .padding(.horizontal, 20)
            .textCase(.none)
            .foregroundColor(.secondary)
            .font(Font.caption.weight(.bold))
            .multilineTextAlignment(.center)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

}

struct TVShowDetailsHeader_Previews: PreviewProvider {

    static var previews: some View {
        let tvShow = TVShow(
            id: 1,
            name: "The Boys",
            overview: "The boys boys boys.",
            firstAirDate: Date(),
            genres: [
                Genre(id: 1, name: "Drama"),
                Genre(id: 2, name: "Action")
            ],
            voteAverage: 7.5
        )

        return TVShowDetailsHeader(tvShow: tvShow)
    }

}
