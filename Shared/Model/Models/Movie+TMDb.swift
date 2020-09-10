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
                  releaseDate: movie.releaseDate, posterURL: movie.posterURL, backdropURL: movie.backdropURL,
                  popularity: movie.popularity)
    }

    static func create(movies: [TMDb.Movie]) -> [Movie] {
        movies.map(Self.init)
    }

}

extension TMDb.Movie: PosterURLProviding, BackdropURLProviding { }
