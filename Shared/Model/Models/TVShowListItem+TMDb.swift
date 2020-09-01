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
                  posterURL: tvShow.posterURL, backdropURL: tvShow.backdropURL, popularity: tvShow.popularity ?? 0)
    }

    static func create(tvShows: [TMDb.TVShowListResultItem]) -> [TVShowListItem] {
        tvShows.map(Self.init)
    }

}

extension TMDb.TVShowListResultItem: PosterURLProviding, BackdropURLProviding { }
