//
//  MoviesAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum MoviesAction {

    case fetchTrending
    case fetchNextTrendingIfNeeded(currentMovie: Movie, offset: Int = 15)
    case appendTrending(movies: [Movie])
    case fetchDiscover
    case fetchNextDiscoverIfNeeded(currentMovie: Movie, offset: Int = 15)
    case appendDiscover(movies: [Movie])
    case fetchMovie(id: Movie.ID)
    case appendMovie(movie: Movie)
    case fetchRecommendations(movieID: Movie.ID)
    case setRecommendations(recommendations: [Movie], movieID: Movie.ID)
    case fetchCredits(movieID: Movie.ID)
    case setCredits(credits: Credits, movieID: Movie.ID)

    case fetchFavourites
    case setFavourites(movies: [Movie])
    case addFavourite(movieID: Movie.ID)
    case removeFavourite(movieID: Movie.ID)
    case syncFavouriteCreated(movieID: Movie.ID)
    case addSyncedFavourite(movie: Movie)
    case syncFavouriteDeleted(movieID: Movie.ID)

}
