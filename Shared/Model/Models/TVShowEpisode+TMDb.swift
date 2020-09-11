//
//  TVShowEpisode+TMDb.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation
import TMDb

extension TVShowEpisode {

    init(episode: TMDb.TVShowEpisode) {
        let crew: [CrewMember]? = {
            guard let crew = episode.crew else {
                return nil
            }

            return CrewMember.create(crewMembers: crew)
        }()

        let guestStars: [CastMember]? = {
            guard let guestStars = episode.guestStars else {
                return nil
            }

            return CastMember.create(castMembers: guestStars)
        }()

        self.init(id: episode.id, name: episode.name, episodeNumber: episode.episodeNumber,
                  seasonNumber: episode.seasonNumber, overview: episode.overview, airDate: episode.airDate,
                  productionCode: episode.productionCode, stillURL: episode.stillURL, crew: crew,
                  guestStars: guestStars, voteAverage: episode.voteAverage, voteCount: episode.voteCount)
    }

    static func create(episodes: [TMDb.TVShowEpisode]) -> [Self] {
        episodes.map(Self.init)
    }

}

extension TMDb.TVShowEpisode: StillURLProviding { }
