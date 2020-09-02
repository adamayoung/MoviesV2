//
//  ShowListItem.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

enum ShowListItem: Identifiable, Equatable {

    var id: String {
        switch self {
        case .movie(let movie):
            return "movie-\(movie.id)"

        case .tvShow(let tvShow):
            return "tvShow-\(tvShow.id)"
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

    var backdropURL: URL? {
        switch self {
        case .movie(let movie):
            return movie.backdropURL

        case .tvShow(let tvShow):
            return tvShow.backdropURL
        }
    }

    var popularity: Float {
        switch self {
        case .movie(let movie):
            return movie.popularity

        case .tvShow(let tvShow):
            return tvShow.popularity
        }
    }

    case movie(MovieListItem)
    case tvShow(TVShowListItem)

}

extension ShowListItem: Hashable {

    static func == (lhs: ShowListItem, rhs: ShowListItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
