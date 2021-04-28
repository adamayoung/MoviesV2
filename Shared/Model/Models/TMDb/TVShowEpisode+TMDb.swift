//
//  TVShowEpisode+TMDb.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation
import TMDb

extension TVShowEpisode {

    init(model: TMDb.TVShowEpisode) {
        let crew: [CrewMember]? = {
            guard let crew = model.crew else {
                return nil
            }

            return CrewMember.create(models: crew)
        }()

        let guestStars: [CastMember]? = {
            guard let guestStars = model.guestStars else {
                return nil
            }

            return CastMember.create(models: guestStars)
        }()

        let stillImage = StillImageMetadata(stillURLProvider: model)

        self.init(id: model.id, name: model.name, episodeNumber: model.episodeNumber, seasonNumber: model.seasonNumber,
                  overview: model.overview, airDate: model.airDate, productionCode: model.productionCode,
                  stillImage: stillImage, crew: crew, guestStars: guestStars, voteAverage: model.voteAverage,
                  voteCount: model.voteCount)
    }

    static func create(models: [TMDb.TVShowEpisode]) -> [Self] {
        models.map(Self.init)
    }

}
