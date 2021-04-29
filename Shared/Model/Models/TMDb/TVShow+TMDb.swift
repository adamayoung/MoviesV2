//
//  TVShow+TMDb.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Foundation
import TMDb

extension TVShow {

    init(model: TMDb.TVShow) {
        let seasons: [TVShowSeason]? = {
            guard let seasons = model.seasons else {
                return nil
            }

            return TVShowSeason.create(models: seasons)
        }()

        let genres: [Genre]? = {
            guard let genres = model.genres else {
                return nil
            }

            return Genre.create(models: genres)
        }()

        let voteAverage: Float? = {
            guard let voteAverage = model.voteAverage else {
                return nil
            }

            return voteAverage > 0 ? voteAverage : nil
        }()

        let posterImage = PosterImageMetadata(posterURLProvider: model)
        let backdropImage = BackdropImageMetadata(backdropURLProvider: model)

        self.init(id: model.id, name: model.name, overview: model.overview, firstAirDate: model.firstAirDate,
                  posterImage: posterImage, backdropImage: backdropImage, homepageURL: model.homepageURL,
                  popularity: model.popularity, seasons: seasons, genres: genres, voteAverage: voteAverage)
    }

    static func create(models: [TMDb.TVShow]) -> [Self] {
        models.map(Self.init)
    }

}
