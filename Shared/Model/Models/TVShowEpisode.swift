//
//  TVShowEpisode.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation

struct TVShowEpisode: Identifiable, Equatable {

    let id: Int
    let name: String
    let episodeNumber: Int
    let seasonNumber: Int
    let overview: String?
    let airDate: Date?
    let productionCode: String?
    let stillImage: StillImageMetadata?
    let crew: [CrewMember]?
    let guestStars: [CastMember]?
    let voteAverage: Float?
    let voteCount: Int?

    init(id: Int, name: String, episodeNumber: Int, seasonNumber: Int, overview: String? = nil, airDate: Date? = nil,
         productionCode: String? = nil, stillImage: StillImageMetadata? = nil, crew: [CrewMember]? = nil,
         guestStars: [CastMember]? = nil, voteAverage: Float? = nil, voteCount: Int? = nil) {
        self.id = id
        self.name = name
        self.episodeNumber = episodeNumber
        self.seasonNumber = seasonNumber
        self.overview = overview
        self.airDate = airDate
        self.productionCode = productionCode
        self.stillImage = stillImage
        self.crew = crew
        self.guestStars = guestStars
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

}

extension TVShowEpisode: Hashable {

    static func == (lhs: TVShowEpisode, rhs: TVShowEpisode) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
