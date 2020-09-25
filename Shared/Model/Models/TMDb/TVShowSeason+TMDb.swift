//
//  TVShowSeason+TMDb.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation
import TMDb

extension TVShowSeason {

    init(dto: TVShowSeasonDTO) {
        let episodes: [TVShowEpisode]? = {
            guard let episodes = dto.episodes else {
                return nil
            }

            return TVShowEpisode.create(dtos: episodes)
        }()

        let posterImage = PosterImageMetadata(posterURLProvider: dto)

        self.init(id: dto.id, name: dto.name, seasonNumber: dto.seasonNumber, overview: dto.overview,
                  airDate: dto.airDate, posterImage: posterImage, episodes: episodes)
    }

    static func create(dtos: [TVShowSeasonDTO]) -> [Self] {
        dtos.map(Self.init)
    }

}
