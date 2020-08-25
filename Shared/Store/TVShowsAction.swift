//
//  TVShowsAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum TVShowsAction {

    case fetchTrending
    case setTrending(tvShows: [TVShowListItem])
    case fetchDiscover
    case setDiscover(tvShows: [TVShowListItem])
    case fetch(id: TVShow.ID)
    case appendTVShow(tvShow: TVShow)
    case fetchRecommendations(tvShowID: Movie.ID)
    case setRecommendations(recommendations: [TVShowListItem], tvShowID: TVShow.ID)
    case fetchCredits(tvShowID: TVShow.ID)
    case setCredits(credits: Credits, tvShowID: TVShow.ID)

}
