//
//  MoviesReducer.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

// swiftlint:disable cyclomatic_complexity
func moviesReducer(state: inout MoviesState, action: MoviesAction, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    switch action {
    case .fetchTrending:
        return fetchTrending(state: &state, environment: environment)

    case .appendTrending(let movies):
        return appendTrending(movies: movies, state: &state)

    case .fetchDiscover:
        return fetchDiscover(state: &state, environment: environment)

    case .appendDiscover(let movies):
        return appendDiscover(movies: movies, state: &state)

    case .fetchMovie(let id):
        return fetchMovie(id: id, environment: environment)

    case .appendMovie(let movie):
        return appendMovie(movie: movie, state: &state)

    case .fetchMovieExtended(let id):
        return fetchMovieExtended(id: id, environment: environment)

    case .appendMovieExtended(let movieExtended):
        return appendMovieExtended(movieExtended: movieExtended, state: &state)

    case .fetchRecommendations(let movieID):
        return fetchRecommendations(movieID: movieID, state: &state, environment: environment)

    case .setRecommendations(let recommendations, let movieID):
        return setRecommendations(recommendations: recommendations, movieID: movieID, state: &state)

    case .fetchCredits(let movieID):
        return fetchCredits(movieID: movieID, environment: environment)

    case .setCredits(let credits, let movieID):
        return setCredits(credits: credits, movieID: movieID, state: &state)
    }
}
// swiftlint:enable cyclomatic_complexity

private func fetchTrending(state: inout MoviesState, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    guard !state.isFetchingTrending, state.isMoreTrendingAvailable else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.isFetchingTrending = true
    state.currentTrendingPage += 1

    return environment.moviesManager
        .fetchTrending(page: state.currentTrendingPage)
        .map { .appendTrending(movies: $0) }
        .eraseToAnyPublisher()
}

private func appendTrending(movies: [MovieListItem], state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.isFetchingTrending = false
    guard !movies.isEmpty else {
        state.isMoreTrendingAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    movies.forEach { state.movieList[$0.id] = $0 }
    state.trendingIDs.append(contentsOf: movies.map(\.id))
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchDiscover(state: inout MoviesState, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    guard !state.isFetchingDiscover, state.isMoreDiscoverAvailable else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.isFetchingDiscover = true
    state.currentDiscoverPage += 1

    return environment.moviesManager
        .fetchDiscover(page: state.currentDiscoverPage)
        .map { .appendDiscover(movies: $0) }
        .eraseToAnyPublisher()
}

private func appendDiscover(movies: [MovieListItem], state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.isFetchingDiscover = false
    guard !movies.isEmpty else {
        state.isMoreDiscoverAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    movies.forEach { state.movieList[$0.id] = $0 }
    state.discoverIDs.append(contentsOf: movies.map(\.id))
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchMovie(id: Movie.ID, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    return environment.moviesManager
        .fetchMovie(withID: id)
        .filter { $0 != nil }
        .map { $0! }
        .map { .appendMovie(movie: $0) }
        .eraseToAnyPublisher()
}

private func appendMovie(movie: Movie, state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.movies[movie.id] = movie
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchMovieExtended(id: MovieExtended.ID, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    return environment.moviesManager
        .fetchMovieExtended(withID: id)
        .filter { $0 != nil }
        .map { $0! }
        .map { .appendMovieExtended(movieExtended: $0) }
        .eraseToAnyPublisher()
}

private func appendMovieExtended(movieExtended: MovieExtended, state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.movies[movieExtended.id] = movieExtended.movie
    state.credits[movieExtended.id] = movieExtended.credits
    state.recommendations[movieExtended.id] = movieExtended.recommendations
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchRecommendations(movieID: Movie.ID, state: inout MoviesState, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    return environment.moviesManager
        .fetchRecommendations(forMovie: movieID)
        .map { .setRecommendations(recommendations: $0, movieID: movieID) }
        .eraseToAnyPublisher()
}

private func setRecommendations(recommendations: [MovieListItem], movieID: Movie.ID, state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.recommendations[movieID] = recommendations
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchCredits(movieID: Movie.ID, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    return environment.moviesManager
        .fetchCredits(forMovie: movieID)
        .map { .setCredits(credits: $0, movieID: movieID) }
        .eraseToAnyPublisher()
}

private func setCredits(credits: Credits, movieID: Movie.ID, state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.credits[movieID] = credits
    return Empty()
        .eraseToAnyPublisher()
}
