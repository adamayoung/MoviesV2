//
//  MoviesAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum MoviesAction {

    case fetchTrending
    case appendTrending(movies: [MovieListItem])
    case fetchDiscover
    case appendDiscover(movies: [MovieListItem])
    case fetchMovie(id: Movie.ID)
    case appendMovie(movie: Movie)
    case fetchRecommendations(movieID: Movie.ID)
    case setRecommendations(recommendations: [MovieListItem], movieID: Movie.ID)
    case fetchCredits(movieID: Movie.ID)
    case setCredits(credits: Credits, movieID: Movie.ID)

}
