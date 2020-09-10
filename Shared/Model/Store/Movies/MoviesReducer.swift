//
//  MoviesReducer.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

// swiftlint:disable cyclomatic_complexity function_body_length
func moviesReducer(state: inout MoviesState, action: MoviesAction,
                   environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    switch action {
    case .fetchTrending:
        return fetchTrending(state: &state, environment: environment)

    case .fetchNextTrendingIfNeeded(let currentMovie, let offset):
        return fetchNextTrendingIfNeeded(currentMovie: currentMovie, offset: offset, state: &state)

    case .appendTrending(let movies):
        return appendTrending(movies: movies, state: &state)

    case .fetchDiscover:
        return fetchDiscover(state: &state, environment: environment)

    case .fetchNextDiscoverIfNeeded(let currentMovie, let offset):
        return fetchNextDiscoverIfNeeded(currentMovie: currentMovie, offset: offset, state: &state)

    case .appendDiscover(let movies):
        return appendDiscover(movies: movies, state: &state)

    case .fetchMovie(let id):
        return fetchMovie(id: id, environment: environment)

    case .appendMovie(let movie):
        return appendMovie(movie: movie, state: &state)

    case .fetchRecommendations(let movieID):
        return fetchRecommendations(movieID: movieID, state: &state, environment: environment)

    case .setRecommendations(let recommendations, let movieID):
        return setRecommendations(recommendations: recommendations, movieID: movieID, state: &state)

    case .fetchCredits(let movieID):
        return fetchCredits(movieID: movieID, environment: environment)

    case .setCredits(let credits, let movieID):
        return setCredits(credits: credits, movieID: movieID, state: &state)

    case .fetchFavourites:
        return fetchFavourites(environment: environment)

    case .setFavourites(let movies):
        return setFavourites(movies: movies, state: &state)

    case .addFavourite(let movieID):
        return addFavourite(movieID: movieID, state: &state, environment: environment)

    case .removeFavourite(let movieID):
        return removeFavourite(movieID: movieID, state: &state, environment: environment)

    case .syncFavouriteCreated(let movieID):
        return syncFavouriteCreated(movieID: movieID, state: &state, environment: environment)

    case .addSyncedFavourite(let movie):
        return addSyncedFavourite(movie: movie, state: &state)

    case .syncFavouriteDeleted(let movieID):
        return syncFavouriteDeleted(movieID: movieID, state: &state)
    }
}
// swiftlint:enable cyclomatic_complexity function_body_length

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

private func fetchNextTrendingIfNeeded(currentMovie: Movie, offset: Int,
                                       state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    let index = state.trendingIDs.firstIndex(where: { $0 == currentMovie.id })
    let thresholdIndex = state.trendingIDs.index(state.trendingIDs.endIndex, offsetBy: -offset)
    guard index == thresholdIndex else {
        return Empty()
            .eraseToAnyPublisher()
    }

    return Just(.fetchTrending)
        .eraseToAnyPublisher()
}

private func appendTrending(movies: [Movie], state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.isFetchingTrending = false
    guard !movies.isEmpty else {
        state.isMoreTrendingAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    movies.forEach { state.movies[$0.id] = $0 }
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

private func fetchNextDiscoverIfNeeded(currentMovie: Movie, offset: Int,
                                       state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    let index = state.discoverIDs.firstIndex(where: { $0 == currentMovie.id })
    let thresholdIndex = state.discoverIDs.index(state.discoverIDs.endIndex, offsetBy: -offset)
    guard index == thresholdIndex else {
        return Empty()
            .eraseToAnyPublisher()
    }

    return Just(.fetchDiscover)
        .eraseToAnyPublisher()
}

private func appendDiscover(movies: [Movie], state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.isFetchingDiscover = false
    guard !movies.isEmpty else {
        state.isMoreDiscoverAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    movies.forEach { state.movies[$0.id] = $0 }
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

private func fetchRecommendations(movieID: Movie.ID, state: inout MoviesState, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    return environment.moviesManager
        .fetchRecommendations(forMovie: movieID)
        .map { .setRecommendations(recommendations: $0, movieID: movieID) }
        .eraseToAnyPublisher()
}

private func setRecommendations(recommendations: [Movie], movieID: Movie.ID, state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    var recommendationIDs = state.recommendationsIDs[movieID] ?? []
    recommendations.forEach {
        state.movies[$0.id] = $0
        recommendationIDs.append($0.id)
    }
    state.recommendationsIDs[movieID] = recommendationIDs
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

private func fetchFavourites(environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    environment.favouritesService
        .fetchFavouriteMovies()
        .map { .setFavourites(movies: $0) }
        .eraseToAnyPublisher()
}

private func setFavourites(movies: [Movie], state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    movies.forEach { state.movies[$0.id] = $0 }
    state.favouriteIDs = movies.map(\.id)
    return Empty()
        .eraseToAnyPublisher()
}

private func addFavourite(movieID: Movie.ID, state: inout MoviesState, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    guard !state.favouriteIDs.contains(movieID) else {
        return Empty()
            .eraseToAnyPublisher()
    }

    guard let movie = state.movies[movieID] else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.favouriteIDs.insert(movieID, at: 0)
    return environment.favouritesService.addFavourite(movie: movie)
        .replaceError(with: Void())
        .flatMap { Empty() }
        .eraseToAnyPublisher()
}

private func removeFavourite(movieID: Movie.ID, state: inout MoviesState, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    guard state.favouriteIDs.contains(movieID) else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.favouriteIDs.removeAll { $0 == movieID }
    return environment.favouritesService.removeFavourite(movie: movieID)
        .replaceError(with: Void())
        .flatMap { Empty() }
        .eraseToAnyPublisher()
}

private func syncFavouriteCreated(movieID: Movie.ID, state: inout MoviesState, environment: AppEnvironment) -> AnyPublisher<MoviesAction, Never> {
    guard !state.favouriteIDs.contains(movieID) else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.favouriteIDs.insert(movieID, at: 0)

    return environment.favouritesService
        .fetchFavourite(movie: movieID)
        .map { movie in
            guard let movie = movie else {
                return .syncFavouriteDeleted(movieID: movieID)
            }

            return .addSyncedFavourite(movie: movie)
        }
        .eraseToAnyPublisher()
}

private func addSyncedFavourite(movie: Movie, state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    guard !state.favouriteIDs.contains(movie.id) else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.movies[movie.id] = movie

    return Empty()
        .eraseToAnyPublisher()
}

private func syncFavouriteDeleted(movieID: Movie.ID, state: inout MoviesState) -> AnyPublisher<MoviesAction, Never> {
    state.favouriteIDs.removeAll { $0 == movieID }

    return Empty()
        .eraseToAnyPublisher()
}
