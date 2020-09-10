//
//  Show+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension Show {

    init(item: TMDb.Show) {
        switch item {
        case .movie(let movie):
            self = .movie(Movie(movie: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShow(tvShow: tvShow))
        }
    }

    static func create(showItems: [TMDb.Show]) -> [Show] {
        showItems.compactMap(Self.init)
    }

}
