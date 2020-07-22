//
//  PersonListItem.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import Foundation

struct PersonListItem: Identifiable, Equatable {

    let id: Int
    let name: String?
    let profilePath: URL?
    let knownFor: [KnownForItem]?
    let popularity: Float?

    init(id: Int, name: String? = nil, profilePath: URL? = nil, knownFor: [KnownForItem]? = nil,
         popularity: Float? = nil) {
        self.id = id
        self.name = name
        self.profilePath = profilePath
        self.knownFor = knownFor
        self.popularity = popularity
    }

}

extension PersonListItem {

    enum KnownForItem: Identifiable, Equatable {

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

        var date: Date? {
            switch self {
            case .movie(let movie):
                return movie.releaseDate

            case .tvShow(let tvShow):
                return tvShow.firstAirDate
            }
        }

        case movie(MovieListItem)
        case tvShow(TVShowListItem)

    }

}
