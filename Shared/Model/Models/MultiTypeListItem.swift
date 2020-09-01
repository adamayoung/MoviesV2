//
//  MultiTypeListItem.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation

enum MultiTypeListItem: Identifiable, Equatable {

    var id: String {
        switch self {
        case .movie(let movie):
            return "movie-\(movie.id)"

        case .tvShow(let tvShow):
            return "tvShow-\(tvShow.id)"

        case .person(let person):
            return "person-\(person.id)"
        }
    }

    case movie(MovieListItem)
    case tvShow(TVShowListItem)
    case person(PersonListItem)

}

extension MultiTypeListItem: Hashable {

    static func == (lhs: MultiTypeListItem, rhs: MultiTypeListItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
