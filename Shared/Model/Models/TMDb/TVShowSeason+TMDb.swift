//
//  TVShowSeason+TMDb.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation
import TMDb

extension TVShowSeason {

    init(season: TMDb.TVShowSeason) {
        let episodes: [TVShowEpisode]? = {
            guard let episodes = season.episodes else {
                return nil
            }

            return TVShowEpisode.create(episodes: episodes)
        }()

        self.init(id: season.id, name: season.name, seasonNumber: season.seasonNumber, overview: season.overview,
                  airDate: season.airDate, posterURL: season.posterURL, episodes: episodes)
    }

    static func create(seasons: [TMDb.TVShowSeason]) -> [Self] {
        seasons.map(Self.init)
    }

}

extension TMDb.TVShowSeason: PosterURLProviding { }
