//
//  Show+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension Show {

    init(dto: ShowDTO) {
        switch dto {
        case .movie(let movie):
            self = .movie(Movie(dto: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShow(dto: tvShow))
        }
    }

    static func create(dtos: [ShowDTO]) -> [Show] {
        dtos.compactMap(Self.init)
    }

}
