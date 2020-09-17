//
//  Media+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Media {

    init(item: TMDb.Media) {
        switch item {
        case .movie(let movie):
            self = .movie(Movie(movie: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShow(tvShow: tvShow))

        case .person(let person):
            self = .person(Person(person: person))
        }
    }

    static func create(multiTypeItems: [TMDb.Media]) -> [Media] {
        multiTypeItems.compactMap(Self.init)
    }

}
