//
//  TVShowsAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum TVShowsAction {

    case fetchTrending
    case fetchNextTrendingIfNeeded(currentTVShow: TVShow, offset: Int = 15)
    case appendTrending(tvShows: [TVShow])
    case fetchDiscover
    case fetchNextDiscoverIfNeeded(currentTVShow: TVShow, offset: Int = 15)
    case appendDiscover(tvShows: [TVShow])
    case fetchTVShow(id: TVShow.ID)
    case appendTVShow(tvShow: TVShow)
    case fetchRecommendations(tvShowID: TVShow.ID)
    case setRecommendations(recommendations: [TVShow], tvShowID: TVShow.ID)
    case fetchCredits(tvShowID: TVShow.ID)
    case setCredits(credits: Credits, tvShowID: TVShow.ID)
    case fetchSeason(seasonNumber: Int, tvShowID: TVShow.ID)
    case setSeason(season: TVShowSeason, seasonNumber: Int, tvShowID: TVShow.ID)

}
