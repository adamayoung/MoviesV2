//
//  Show.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

enum Show: Identifiable, Equatable {

    var id: Int {
        switch self {
        case .movie(let movie):
            return movie.id

        case .tvShow(let tvShow):
            return tvShow.id
        }
    }

    var title: String {
        switch self {
        case .movie(let movie):
            return movie.title

        case .tvShow(let tvShow):
            return tvShow.name
        }
    }

    var backdropImage: BackdropImageMetadata? {
        switch self {
        case .movie(let movie):
            return movie.backdropImage

        case .tvShow(let tvShow):
            return tvShow.backdropImage
        }
    }

    var popularity: Double? {
        switch self {
        case .movie(let movie):
            return movie.popularity

        case .tvShow(let tvShow):
            return tvShow.popularity
        }
    }

    case movie(Movie)
    case tvShow(TVShow)

}

extension Show: Hashable {

    static func == (lhs: Show, rhs: Show) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
