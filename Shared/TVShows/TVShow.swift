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
    let overview: String
    let firstAirDate: Date?
    let posterPath: URL?
    let backdropPath: URL?
    let homepageURL: URL?

    init(id: Int, name: String, overview: String, firstAirDate: Date? = nil, posterPath: URL? = nil,
         backdropPath: URL? = nil, homepageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.homepageURL = homepageURL
    }

}
