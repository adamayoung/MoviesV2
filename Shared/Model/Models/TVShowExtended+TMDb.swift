//
//  TVShowExtended+TMDb.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import Foundation
import TMDb

extension TVShowExtended {

    init(tvShow: TMDb.TVShow) {
        let aTVShow = TVShow(tvShow: tvShow)
        let credits: Credits? = {
            guard let credits = tvShow.credits  else {
                return nil
            }

            return Credits(credits: credits)
        }()

        let recommendations: [TVShowListItem]? = {
            guard let recommendations = tvShow.recommendations  else {
                return nil
            }

            return TVShowListItem.create(tvShows: recommendations.results)
        }()

        self.init(id: tvShow.id, tvShow: aTVShow, credits: credits, recommendations: recommendations)
    }

}
