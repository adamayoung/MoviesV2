//
//  MoviesAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum MoviesAction {

    case fetchTrending
    case fetchNextTrendingIfNeeded(currentMovie: MovieListItem, offset: Int = 15)
    case appendTrending(movies: [MovieListItem])
    case fetchDiscover
    case fetchNextDiscoverIfNeeded(currentMovie: MovieListItem, offset: Int = 15)
    case appendDiscover(movies: [MovieListItem])
    case fetchMovie(id: Movie.ID)
    case appendMovie(movie: Movie)
    case fetchMovieExtended(id: MovieExtended.ID)
    case appendMovieExtended(movieExtended: MovieExtended)
    case fetchRecommendations(movieID: Movie.ID)
    case setRecommendations(recommendations: [MovieListItem], movieID: Movie.ID)
    case fetchCredits(movieID: Movie.ID)
    case setCredits(credits: Credits, movieID: Movie.ID)

    case fetchFavourites
    case setFavourites(movies: [MovieListItem])
    case addFavourite(movieID: Movie.ID)
    case removeFavourite(movieID: Movie.ID)
    case syncFavouriteCreated(movieID: Movie.ID)
    case addSyncedFavourite(movie: MovieListItem)
    case syncFavouriteDeleted(movieID: Movie.ID)

}
