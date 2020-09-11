//
//  TVShow+TMDb.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Foundation
import TMDb

extension TVShow {

    init(tvShow: TMDb.TVShow) {
        let seasons: [TVShowSeason]? = {
            guard let seasons = tvShow.seasons else {
                return nil
            }

            return TVShowSeason.create(seasons: seasons)
        }()

        self.init(id: tvShow.id, name: tvShow.name, overview: tvShow.overview, firstAirDate: tvShow.firstAirDate,
                  posterURL: tvShow.posterURL, backdropURL: tvShow.backdropURL, homepageURL: tvShow.homepageURL,
                  popularity: tvShow.popularity, seasons: seasons)
    }

    static func create(tvShows: [TMDb.TVShow]) -> [Self] {
        tvShows.map(Self.init)
    }

}

extension TMDb.TVShow: PosterURLProviding, BackdropURLProviding { }
