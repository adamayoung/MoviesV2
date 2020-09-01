//
//  TVShowListItem.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Foundation

struct TVShowListItem: Identifiable, Equatable {

    let id: Int
    let name: String
    let overview: String?
    let firstAirDate: Date?
    let posterURL: URL?
    let backdropURL: URL?
    let popularity: Float

    init(id: Int, name: String, overview: String? = nil, firstAirDate: Date? = nil, posterURL: URL? = nil,
         backdropURL: URL? = nil, popularity: Float = 0) {
        self.id = id
        self.name = name
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.posterURL = posterURL
        self.backdropURL = backdropURL
        self.popularity = popularity
    }

}

extension TVShowListItem: Hashable {

    static func == (lhs: TVShowListItem, rhs: TVShowListItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

extension Array where Element == TVShowListItem {

    func sortedByPopularity(limit: Int? = nil) -> [TVShowListItem] {
        let tvShows = sorted { $0.popularity > $1.popularity }
        guard let limit = limit else {
            return tvShows
        }

        return Array(tvShows.prefix(limit))
    }

}
