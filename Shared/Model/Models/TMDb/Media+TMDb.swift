//
//  Media+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Media {

    init(dto: MediaDTO) {
        switch dto {
        case .movie(let movie):
            self = .movie(Movie(dto: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShow(dto: tvShow))

        case .person(let person):
            self = .person(Person(dto: person))
        }
    }

    static func create(dtos: [MediaDTO]) -> [Media] {
        dtos.compactMap(Self.init)
    }

}
