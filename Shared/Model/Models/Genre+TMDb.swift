//
//  Genre+TMDb.swift
//  Movies
//
//  Created by Adam Young on 16/09/2020.
//

import Foundation
import TMDb

extension Genre {

    init(genre: TMDb.Genre) {
        self.init(id: genre.id, name: genre.name)
    }

    static func create(genres: [TMDb.Genre]) -> [Genre] {
        genres.map(Self.init)
    }

}
