//
//  MoviesReducer.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

func moviesReducer(state: inout MoviesState, action: MoviesAction, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    switch action {
    case .fetchTrending:
        guard !state.isFetchingTrending else {
            break
        }

        guard state.isMoreTrendingAvailable else {
            break
        }

        state.isFetchingTrending = true
        state.currentTrendingPage += 1

        return environment.moviesManager
            .fetchTrending(page: state.currentTrendingPage)
            .map { .appendTrending(movies: $0) }
            .eraseToAnyPublisher()

    case .appendTrending(let movies):
        state.isFetchingTrending = false
        guard !movies.isEmpty else {
            state.isMoreTrendingAvailable = false
            break
        }

        mergeTrending(movies, into: &state)

    case .fetchDiscover:
        guard !state.isFetchingDiscover else {
            break
        }

        guard state.isMoreDiscoverAvailable else {
            break
        }

        state.isFetchingDiscover = true
        state.currentDiscoverPage += 1

        return environment.moviesManager
            .fetchDiscover(page: state.currentDiscoverPage)
            .map { .appendDiscover(movies: $0) }
            .eraseToAnyPublisher()

    case .appendDiscover(let movies):
        state.isFetchingDiscover = false
        guard !movies.isEmpty else {
            state.isMoreDiscoverAvailable = false
            break
        }

        mergeDiscover(movies, into: &state)

    case .fetch(let id):
        return environment.moviesManager
            .fetchMovie(withID: id)
            .filter { $0 != nil }
            .map { $0! }
            .map { .appendMovie(movie: $0) }
            .eraseToAnyPublisher()

    case .appendMovie(let movie):
        state.movies[movie.id] = movie

    case .fetchRecommendations(let movieID):
        return environment.moviesManager
            .fetchRecommendations(forMovie: movieID)
            .map { .setRecommendations(recommendations: $0, movieID: movieID) }
            .eraseToAnyPublisher()

    case .setRecommendations(let recommendations, let movieID):
        state.recommendations[movieID] = recommendations

    case .fetchCredits(let movieID):
        return environment.moviesManager
            .fetchCredits(forMovie: movieID)
            .map { .setCredits(credits: $0, movieID: movieID) }
            .eraseToAnyPublisher()

    case .setCredits(let credits, let movieID):
        state.credits[movieID] = credits
    }

    return Empty().eraseToAnyPublisher()
}

fileprivate func mergeTrending(_ movies: [MovieListItem], into state: inout MoviesState) {
    movies.forEach {
        state.movieList[$0.id] = $0
    }

    state.trendingIDs.append(contentsOf: movies.map(\.id))
}

fileprivate func mergeDiscover(_ movies: [MovieListItem], into state: inout MoviesState) {
    movies.forEach {
        state.movieList[$0.id] = $0
    }

    state.discoverIDs.append(contentsOf: movies.map(\.id))
}
