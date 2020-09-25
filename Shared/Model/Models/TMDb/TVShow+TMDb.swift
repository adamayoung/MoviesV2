//
//  TVShow+TMDb.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Foundation
import TMDb

extension TVShow {

    init(dto: TVShowDTO) {
        let seasons: [TVShowSeason]? = {
            guard let seasons = dto.seasons else {
                return nil
            }

            return TVShowSeason.create(dtos: seasons)
        }()

        let genres: [Genre]? = {
            guard let genres = dto.genres else {
                return nil
            }

            return Genre.create(dtos: genres)
        }()

        let voteAverage: Float? = {
            guard let voteAverage = dto.voteAverage else {
                return nil
            }

            return voteAverage > 0 ? voteAverage : nil
        }()

        let posterImage = PosterImageMetadata(posterURLProvider: dto)
        let backdropImage = BackdropImageMetadata(backdropURLProvider: dto)

        self.init(id: dto.id, name: dto.name, overview: dto.overview, firstAirDate: dto.firstAirDate,
                  posterImage: posterImage, backdropImage: backdropImage, homepageURL: dto.homepageURL,
                  popularity: dto.popularity, seasons: seasons, genres: genres, voteAverage: voteAverage)
    }

    static func create(dtos: [TVShowDTO]) -> [Self] {
        dtos.map(Self.init)
    }

}
