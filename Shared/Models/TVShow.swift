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
    let posterURL: URL?
    let backdropURL: URL?
    let homepageURL: URL?

    init(id: Int, name: String, overview: String, firstAirDate: Date? = nil, posterURL: URL? = nil,
         backdropURL: URL? = nil, homepageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.posterURL = posterURL
        self.backdropURL = backdropURL
        self.homepageURL = homepageURL
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