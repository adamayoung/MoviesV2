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
    let posterPath: URL?
    let backdropPath: URL?

    init(id: Int, name: String, overview: String? = nil, firstAirDate: Date? = nil, posterPath: URL? = nil,
         backdropPath: URL? = nil) {
        self.id = id
        self.name = name
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }

}
