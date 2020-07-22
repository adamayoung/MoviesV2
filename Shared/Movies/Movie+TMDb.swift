//
//  Movie+TMDb.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Foundation
import TMDb

extension Movie {

    init(movie: TMDb.Movie) {
        self.init(id: movie.id, title: movie.title, tagline: movie.tagline, overview: movie.overview,
                  releaseDate: movie.releaseDate, posterPath: movie.posterPath, backdropPath: movie.backdropPath)
    }

}
