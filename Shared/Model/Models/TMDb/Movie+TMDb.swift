//
//  Movie+TMDb.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Foundation
import TMDb

extension Movie {

    init(dto: MovieDTO) {
        let genres: [Genre]? = {
            guard let genres = dto.genres else {
                return nil
            }

            return Genre.create(dtos: genres)
        }()

        let runtime: TimeInterval? = {
            guard let runtime = dto.runtime else {
                return nil
            }

            return TimeInterval(runtime * 60)
        }()

        let voteAverage: Float? = {
            guard let voteAverage = dto.voteAverage else {
                return nil
            }

            return voteAverage > 0 ? voteAverage : nil
        }()

        let posterImage = PosterImageMetadata(posterURLProvider: dto)
        let backdropImage = BackdropImageMetadata(backdropURLProvider: dto)

        self.init(id: dto.id, title: dto.title, tagline: dto.tagline, overview: dto.overview, runtime: runtime,
                  genres: genres, releaseDate: dto.releaseDate, posterImage: posterImage, backdropImage: backdropImage,
                  popularity: dto.popularity, voteAverage: voteAverage)
    }

    static func create(dtos: [MovieDTO]) -> [Movie] {
        dtos.map(Self.init)
    }

}
