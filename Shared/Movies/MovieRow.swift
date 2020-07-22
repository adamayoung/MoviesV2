//
//  MovieRow.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct MovieRow: View {

    private static let yearDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter
    }()

    var title: String
    var posterPath: URL?
    var date: Date?

    init(title: String, posterPath: URL? = nil, date: Date? = nil) {
        self.title = title
        self.posterPath = posterPath
        self.date = date
    }

    var body: some View {
        HStack(alignment: .center) {
            PosterImage(path: posterPath, displaySize: .medium)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)

                Group {
                    if let date = date {
                        Text("\(date, formatter: Self.yearDateFormatter)")
                    }
                }
                .foregroundColor(.gray)
                .font(.subheadline)
            }
        }
    }

}

extension MovieRow {

    init(movie: MovieListItem) {
        self.init(title: movie.title, posterPath: movie.posterPath, date: movie.releaseDate)
    }

}

struct MovieRow_Previews: PreviewProvider {

    static var previews: some View {
        List {
            MovieRow(title: "Ad Astra",
                    posterPath: URL(string: "https://image.tmdb.org/t/p/w780/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")!,
                    date: Date())
        }
    }

}
