//
//  Movie.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Foundation

struct Movie: Identifiable, Equatable {

    let id: Int
    let title: String
    let tagline: String?
    let overview: String?
    let runtime: TimeInterval?
    let genres: [Genre]?
    let releaseDate: Date?
    let posterImage: PosterImageMetadata?
    let backdropImage: BackdropImageMetadata?
    let popularity: Float?
    let voteAverage: Float?

    init(id: Int, title: String, tagline: String? = nil, overview: String? = nil, runtime: TimeInterval? = nil,
         genres: [Genre]? = nil, releaseDate: Date? = nil, posterImage: PosterImageMetadata? = nil,
         backdropImage: BackdropImageMetadata? = nil, popularity: Float? = nil, voteAverage: Float? = nil) {
        self.id = id
        self.title = title
        self.tagline = tagline
        self.overview = overview
        self.runtime = runtime
        self.genres = genres
        self.releaseDate = releaseDate
        self.posterImage = posterImage
        self.backdropImage = backdropImage
        self.popularity = popularity
        self.voteAverage = voteAverage
    }

}

extension Movie: Hashable {

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
