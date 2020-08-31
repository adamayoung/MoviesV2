//
//  TVShowsAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum TVShowsAction {

    case fetchTrending
    case fetchNextTrendingIfNeeded(currentTVShow: TVShowListItem, offset: Int = 15)
    case appendTrending(tvShows: [TVShowListItem])
    case fetchDiscover
    case fetchNextDiscoverIfNeeded(currentTVShow: TVShowListItem, offset: Int = 15)
    case appendDiscover(tvShows: [TVShowListItem])
    case fetchTVShow(id: TVShow.ID)
    case appendTVShow(tvShow: TVShow)
    case fetchTVShowExtended(id: TVShowExtended.ID)
    case appendTVShowExtended(tvShowExtended: TVShowExtended)
    case fetchRecommendations(tvShowID: Movie.ID)
    case setRecommendations(recommendations: [TVShowListItem], tvShowID: TVShow.ID)
    case fetchCredits(tvShowID: TVShow.ID)
    case setCredits(credits: Credits, tvShowID: TVShow.ID)

}
