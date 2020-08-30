//
//  TVShowsReducer.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

// swiftlint:disable cyclomatic_complexity
func tvShowsReducer(state: inout TVShowsState, action: TVShowsAction, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    switch action {
    case .fetchTrending:
        return fetchTrending(state: &state, environment: environment)

    case .appendTrending(let tvShows):
        return appendTrending(tvShows: tvShows, state: &state)

    case .fetchDiscover:
        return fetchDiscover(state: &state, environment: environment)

    case .appendDiscover(let tvShows):
        return appendDiscover(tvShows: tvShows, state: &state)

    case .fetchTVShow(let id):
        return fetchTVShow(id: id, environment: environment)

    case .appendTVShow(let tvShow):
        return appendTVShow(tvShow: tvShow, state: &state)

    case .fetchTVShowExtended(let id):
        return fetchTVShowExtended(id: id, environment: environment)

    case .appendTVShowExtended(let tvShowExtended):
        return appendTVShowExtended(tvShowExtended: tvShowExtended, state: &state)

    case .fetchRecommendations(let tvShowID):
        return fetchRecommendations(tvShowID: tvShowID, state: &state, environment: environment)

    case .setRecommendations(let recommendations, let tvShowID):
        return setRecommendations(recommendations: recommendations, tvShowID: tvShowID, state: &state)

    case .fetchCredits(let tvShowID):
        return fetchCredits(tvShowID: tvShowID, environment: environment)

    case .setCredits(let credits, let tvShowID):
        return setCredits(credits: credits, tvShowID: tvShowID, state: &state)
    }
}
// swiftlint:enable cyclomatic_complexity

private func fetchTrending(state: inout TVShowsState, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    guard !state.isFetchingTrending, state.isMoreTrendingAvailable else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.isFetchingTrending = true
    state.currentTrendingPage += 1

    return environment.tvShowsManager
        .fetchTrending(page: state.currentTrendingPage)
        .map { .appendTrending(tvShows: $0) }
        .eraseToAnyPublisher()
}

private func appendTrending(tvShows: [TVShowListItem], state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.isFetchingTrending = false
    guard !tvShows.isEmpty else {
        state.isMoreTrendingAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    tvShows.forEach { state.tvShowList[$0.id] = $0 }
    state.trendingIDs.append(contentsOf: tvShows.map(\.id))
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchDiscover(state: inout TVShowsState, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    guard !state.isFetchingDiscover, state.isMoreDiscoverAvailable else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.isFetchingDiscover = true
    state.currentDiscoverPage += 1

    return environment.tvShowsManager
        .fetchDiscover(page: state.currentDiscoverPage)
        .map { .appendDiscover(tvShows: $0) }
        .eraseToAnyPublisher()
}

private func appendDiscover(tvShows: [TVShowListItem], state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.isFetchingDiscover = false
    guard !tvShows.isEmpty else {
        state.isMoreDiscoverAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    tvShows.forEach { state.tvShowList[$0.id] = $0 }
    state.discoverIDs.append(contentsOf: tvShows.map(\.id))
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchTVShow(id: TVShow.ID, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    return environment.tvShowsManager
        .fetchTVShow(withID: id)
        .filter { $0 != nil }
        .map { $0! }
        .map { .appendTVShow(tvShow: $0) }
        .eraseToAnyPublisher()
}

private func appendTVShow(tvShow: TVShow, state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.tvShows[tvShow.id] = tvShow
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchTVShowExtended(id: TVShowExtended.ID,
                                 environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    return environment.tvShowsManager
        .fetchTVShowExtended(withID: id)
        .filter { $0 != nil }
        .map { $0! }
        .map { .appendTVShowExtended(tvShowExtended: $0) }
        .eraseToAnyPublisher()
}

private func appendTVShowExtended(tvShowExtended: TVShowExtended,
                                  state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.tvShows[tvShowExtended.id] = tvShowExtended.tvShow
    state.credits[tvShowExtended.id] = tvShowExtended.credits
    state.recommendations[tvShowExtended.id] = tvShowExtended.recommendations
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchRecommendations(tvShowID: TVShow.ID, state: inout TVShowsState, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    return environment.tvShowsManager
        .fetchRecommendations(forTVShow: tvShowID)
        .map { .setRecommendations(recommendations: $0, tvShowID: tvShowID) }
        .eraseToAnyPublisher()
}

private func setRecommendations(recommendations: [TVShowListItem], tvShowID: TVShow.ID, state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.recommendations[tvShowID] = recommendations
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchCredits(tvShowID: TVShow.ID, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    return environment.tvShowsManager
        .fetchCredits(forTVShow: tvShowID)
        .map { .setCredits(credits: $0, tvShowID: tvShowID) }
        .eraseToAnyPublisher()
}

private func setCredits(credits: Credits, tvShowID: TVShow.ID, state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.credits[tvShowID] = credits
    return Empty()
        .eraseToAnyPublisher()
}
