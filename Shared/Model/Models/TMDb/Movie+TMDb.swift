//
//  Movie+TMDb.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Foundation
import TMDb

extension Movie {

    init(model: TMDb.Movie) {
        let genres: [Genre]? = {
            guard let genres = model.genres else {
                return nil
            }

            return Genre.create(models: genres)
        }()

        let runtime: TimeInterval? = {
            guard let runtime = model.runtime else {
                return nil
            }

            return TimeInterval(runtime * 60)
        }()

        let voteAverage: Float? = {
            guard let voteAverage = model.voteAverage else {
                return nil
            }

            return voteAverage > 0 ? voteAverage : nil
        }()

        let posterImage = PosterImageMetadata(posterURLProvider: model)
        let backdropImage = BackdropImageMetadata(backdropURLProvider: model)

        self.init(id: model.id, title: model.title, tagline: model.tagline, overview: model.overview, runtime: runtime,
                  genres: genres, releaseDate: model.releaseDate, posterImage: posterImage,
                  backdropImage: backdropImage, popularity: model.popularity, voteAverage: voteAverage)
    }

    static func create(models: [TMDb.Movie]) -> [Movie] {
        models.map(Self.init)
    }

}
