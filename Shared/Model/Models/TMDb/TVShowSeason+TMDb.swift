//
//  TVShowSeason+TMDb.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation
import TMDb

extension TVShowSeason {

    init(model: TMDb.TVShowSeason) {
        let episodes: [TVShowEpisode]? = {
            guard let episodes = model.episodes else {
                return nil
            }

            return TVShowEpisode.create(models: episodes)
        }()

        let posterImage = PosterImageMetadata(posterURLProvider: model)

        self.init(id: model.id, name: model.name, seasonNumber: model.seasonNumber, overview: model.overview,
                  airDate: model.airDate, posterImage: posterImage, episodes: episodes)
    }

    static func create(models: [TMDb.TVShowSeason]) -> [Self] {
        models.map(Self.init)
    }

}
