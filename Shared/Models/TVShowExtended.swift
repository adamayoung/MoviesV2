//
//  TVShowExtended.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import Foundation

struct TVShowExtended: Identifiable, Equatable {

    let id: TVShow.ID
    let tvShow: TVShow
    let credits: Credits?
    let recommendations: [TVShowListItem]?

    init(id: TVShow.ID, tvShow: TVShow, credits: Credits? = nil, recommendations: [TVShowListItem]? = nil) {
        self.id = id
        self.tvShow = tvShow
        self.credits = credits
        self.recommendations = recommendations
    }

}
