//
//  TVShowSeason.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation

struct TVShowSeason: Identifiable, Equatable {

    let id: Int
    let name: String
    let seasonNumber: Int
    let overview: String?
    let airDate: Date?
    let posterImage: PosterImageMetadata?
    let episodes: [TVShowEpisode]?

    init(id: Int, name: String, seasonNumber: Int, overview: String? = nil, airDate: Date? = nil,
         posterImage: PosterImageMetadata? = nil, episodes: [TVShowEpisode]? = nil) {
        self.id = id
        self.name = name
        self.seasonNumber = seasonNumber
        self.overview = overview
        self.airDate = airDate
        self.posterImage = posterImage
        self.episodes = episodes
    }

}

extension TVShowSeason: Hashable {

    static func == (lhs: TVShowSeason, rhs: TVShowSeason) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
