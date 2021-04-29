//
//  MovieRow.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct MovieRow: View {

    var movie: Movie

    var verticalRowPadding: CGFloat {
        #if os(macOS)
        return 10
        #else
        return 0
        #endif
    }

    var body: some View {
        HStack(alignment: .center) {
            PosterImage(imageMetadata: movie.posterImage, displaySize: .small)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)

                if let releaseDate = movie.releaseDate {
                    Text("\(releaseDate, formatter: DateFormatter.year)")
                        .foregroundColor(.secondary)
                }
            }
        }
        .font(.subheadline)
        .padding(.vertical, verticalRowPadding)
    }

}

// struct MovieRow_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let movie = Movie(id: 1,
//                          title: "Ad Astra",
//                          releaseDate: Date(),
//                          posterURL: URL(string: "https://image.tmdb.org/t/p/w780/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg"))
//
//        return List {
//            MovieRow(movie: movie)
//        }
//    }
//
// }
