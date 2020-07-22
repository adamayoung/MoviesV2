//
//  TVShowListItem+TMDb.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Foundation
import TMDb

extension TVShowListItem {

    init(tvShow: TMDb.TVShowListResultItem) {
        self.init(id: tvShow.id, name: tvShow.name, overview: tvShow.overview, firstAirDate: tvShow.firstAirDate,
                  posterPath: tvShow.posterPath, backdropPath: tvShow.backdropPath)
    }

    static func create(tvShows: [TMDb.TVShowListResultItem]) -> [TVShowListItem] {
        tvShows.map(Self.init)
    }

}
