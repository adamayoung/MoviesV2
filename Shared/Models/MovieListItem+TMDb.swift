//
//  MovieListItem+TMDb.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Foundation
import TMDb

extension MovieListItem {

    init(movie: TMDb.MovieListResultItem) {
        self.init(id: movie.id, title: movie.title, overview: movie.overview, releaseDate: movie.releaseDate,
                  posterURL: movie.posterURL, backdropURL: movie.backdropURL, popularity: movie.popularity ?? 0)
    }

    static func create(movies: [TMDb.MovieListResultItem]) -> [MovieListItem] {
        movies.map(Self.init)
    }

}

extension TMDb.MovieListResultItem: PosterURLProviding, BackdropURLProviding { }
