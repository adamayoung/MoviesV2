//
//  TVShowEpisode+TMDb.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation
import TMDb

extension TVShowEpisode {

    init(dto: TVShowEpisodeDTO) {
        let crew: [CrewMember]? = {
            guard let crew = dto.crew else {
                return nil
            }

            return CrewMember.create(dtos: crew)
        }()

        let guestStars: [CastMember]? = {
            guard let guestStars = dto.guestStars else {
                return nil
            }

            return CastMember.create(dtos: guestStars)
        }()

        let stillImage = StillImageMetadata(stillURLProvider: dto)

        self.init(id: dto.id, name: dto.name, episodeNumber: dto.episodeNumber, seasonNumber: dto.seasonNumber,
                  overview: dto.overview, airDate: dto.airDate, productionCode: dto.productionCode,
                  stillImage: stillImage, crew: crew, guestStars: guestStars, voteAverage: dto.voteAverage,
                  voteCount: dto.voteCount)
    }

    static func create(dtos: [TVShowEpisodeDTO]) -> [Self] {
        dtos.map(Self.init)
    }

}
