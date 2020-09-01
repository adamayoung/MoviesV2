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
    let profileURL: URL?
    let knownFor: [KnownForItem]?
    let popularity: Float?

    var knownForSummary: String? {
        guard let knownForItem = knownFor?.first else {
            return nil
        }

        var summary = knownForItem.title
        if let date = knownForItem.date {
            summary += " (\(DateFormatter.year.string(from: date)))"
        }

        return summary
    }

    init(id: Int, name: String? = nil, profileURL: URL? = nil, knownFor: [KnownForItem]? = nil,
         popularity: Float? = nil) {
        self.id = id
        self.name = name
        self.profileURL = profileURL
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

extension PersonListItem: Hashable {

    static func == (lhs: PersonListItem, rhs: PersonListItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

extension PersonListItem.KnownForItem: Hashable {

    static func == (lhs: PersonListItem.KnownForItem, rhs: PersonListItem.KnownForItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
