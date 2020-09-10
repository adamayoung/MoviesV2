//
//  Media.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation

enum Media: Identifiable, Equatable {

    var id: Int {
        switch self {
        case .movie(let movie):
            return movie.id

        case .tvShow(let tvShow):
            return tvShow.id

        case .person(let person):
            return person.id
        }
    }

    case movie(Movie)
    case tvShow(TVShow)
    case person(Person)

}

extension Media: Hashable {

    static func == (lhs: Media, rhs: Media) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
