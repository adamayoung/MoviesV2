//
//  Show+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension Show {

    init(model: TMDb.Show) {
        switch model {
        case .movie(let movie):
            self = .movie(Movie(model: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShow(model: tvShow))
        }
    }

    static func create(models: [TMDb.Show]) -> [Show] {
        models.map(Self.init)
    }

}
