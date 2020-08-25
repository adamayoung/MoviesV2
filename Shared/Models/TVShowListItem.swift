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

    init(id: Int, name: String, overview: String? = nil, firstAirDate: Date? = nil, posterURL: URL? = nil,
         backdropURL: URL? = nil) {
        self.id = id
        self.name = name
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.posterURL = posterURL
        self.backdropURL = backdropURL
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
