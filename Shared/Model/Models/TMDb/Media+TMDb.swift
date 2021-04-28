//
//  Media+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Media {

    init(model: TMDb.Media) {
        switch model {
        case .movie(let movie):
            self = .movie(Movie(model: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShow(model: tvShow))

        case .person(let person):
            self = .person(Person(model: person))
        }
    }

    static func create(models: [TMDb.Media]) -> [Media] {
        models.map(Self.init)
    }

}
