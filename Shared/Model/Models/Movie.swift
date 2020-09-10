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
    let releaseDate: Date?
    let posterURL: URL?
    let backdropURL: URL?
    let popularity: Float?

    init(id: Int, title: String, tagline: String? = nil, overview: String? = nil, releaseDate: Date? = nil,
         posterURL: URL? = nil, backdropURL: URL? = nil, popularity: Float? = nil) {
        self.id = id
        self.title = title
        self.tagline = tagline
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterURL = posterURL
        self.backdropURL = backdropURL
        self.popularity = popularity
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
