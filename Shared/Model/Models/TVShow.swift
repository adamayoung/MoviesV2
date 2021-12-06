//
//  TVShow.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Foundation

struct TVShow: Identifiable, Equatable {

    let id: Int
    let name: String
    let overview: String?
    let firstAirDate: Date?
    let posterImage: PosterImageMetadata?
    let backdropImage: BackdropImageMetadata?
    let homepageURL: URL?
    let popularity: Double?
    let seasons: [TVShowSeason]?
    let genres: [Genre]?
    let voteAverage: Double?

    init(id: Int, name: String, overview: String? = nil, firstAirDate: Date? = nil,
         posterImage: PosterImageMetadata? = nil, backdropImage: BackdropImageMetadata? = nil, homepageURL: URL? = nil,
         popularity: Double? = nil, seasons: [TVShowSeason]? = nil, genres: [Genre]? = nil, voteAverage: Double? = nil) {
        self.id = id
        self.name = name
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.posterImage = posterImage
        self.backdropImage = backdropImage
        self.homepageURL = homepageURL
        self.popularity = popularity
        self.seasons = seasons
        self.genres = genres
        self.voteAverage = voteAverage
    }

}

extension TVShow: Hashable {

    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
