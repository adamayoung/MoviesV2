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
        let genres: [Genre]? = {
            guard let genres = movie.genres else {
                return nil
            }

            return Genre.create(genres: genres)
        }()

        let runtime: TimeInterval? = {
            guard let runtime = movie.runtime else {
                return nil
            }

            return TimeInterval(runtime * 60)
        }()

        self.init(id: movie.id, title: movie.title, tagline: movie.tagline, overview: movie.overview, runtime: runtime,
                  genres: genres, releaseDate: movie.releaseDate, posterURL: movie.posterURL,
                  backdropURL: movie.backdropURL, popularity: movie.popularity, voteAverage: movie.voteAverage)
    }

    static func create(movies: [TMDb.Movie]) -> [Movie] {
        movies.map(Self.init)
    }

}

extension TMDb.Movie: PosterURLProviding, BackdropURLProviding { }
