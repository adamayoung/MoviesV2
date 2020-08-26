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

    init(id: Int, title: String, overview: String? = nil, releaseDate: Date? = nil, posterURL: URL? = nil,
         backdropURL: URL? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterURL = posterURL
        self.backdropURL = backdropURL
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
