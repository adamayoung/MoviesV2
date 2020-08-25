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
        self.init(id: tvShow.id, name: tvShow.name, overview: tvShow.overview, firstAirDate: tvShow.firstAirDate,
                  posterURL: tvShow.posterURL, backdropURL: tvShow.backdropURL, homepageURL: tvShow.homepageURL)
    }

}

extension TMDb.TVShow: PosterURLProviding, BackdropURLProviding { }
