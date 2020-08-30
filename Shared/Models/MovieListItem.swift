//
//  MovieListItem.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Foundation

struct MovieListItem: Identifiable, Equatable {

    let id: Int
    let title: String
    let overview: String?
    let releaseDate: Date?
    let posterURL: URL?
    let backdropURL: URL?
    let popularity: Float

    init(id: Int, title: String, overview: String? = nil, releaseDate: Date? = nil, posterURL: URL? = nil,
         backdropURL: URL? = nil, popularity: Float = 0) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterURL = posterURL
        self.backdropURL = backdropURL
        self.popularity = popularity
    }

}

extension MovieListItem: Hashable {

    static func == (lhs: MovieListItem, rhs: MovieListItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

extension Array where Element == MovieListItem {

    func sortedByPopularity(limit: Int? = nil) -> [MovieListItem] {
        let movies = sorted { $0.popularity > $1.popularity }
        guard let limit = limit else {
            return movies
        }

        return Array(movies.prefix(limit))
    }

}
