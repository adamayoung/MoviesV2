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
    let posterPath: URL?
    let backdropPath: URL?

    init(id: Int, title: String, overview: String? = nil, releaseDate: Date? = nil, posterPath: URL? = nil,
         backdropPath: URL? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }

}
