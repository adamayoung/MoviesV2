//
//  TVShowsReducer.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

// swiftlint:disable cyclomatic_complexity
func tvShowsReducer(state: inout TVShowsState, action: TVShowsAction,
                    environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    switch action {
    case .fetchTrending:
        return fetchTrending(state: &state, environment: environment)

    case .fetchNextTrendingIfNeeded(let currentTVShow, let offset):
        return fetchNextTrendingIfNeeded(currentTVShow: currentTVShow, offset: offset, state: &state)

    case .appendTrending(let tvShows):
        return appendTrending(tvShows: tvShows, state: &state)

    case .fetchDiscover:
        return fetchDiscover(state: &state, environment: environment)

    case .fetchNextDiscoverIfNeeded(let currentTVShow, let offset):
        return fetchNextDiscoverIfNeeded(currentTVShow: currentTVShow, offset: offset, state: &state)

    case .appendDiscover(let tvShows):
        return appendDiscover(tvShows: tvShows, state: &state)

    case .fetchTVShow(let id):
        return fetchTVShow(id: id, environment: environment)

    case .appendTVShow(let tvShow):
        return appendTVShow(tvShow: tvShow, state: &state)

    case .fetchRecommendations(let tvShowID):
        return fetchRecommendations(tvShowID: tvShowID, state: &state, environment: environment)

    case .setRecommendations(let recommendations, let tvShowID):
        return setRecommendations(recommendations: recommendations, tvShowID: tvShowID, state: &state)

    case .fetchCredits(let tvShowID):
        return fetchCredits(tvShowID: tvShowID, environment: environment)

    case .setCredits(let credits, let tvShowID):
        return setCredits(credits: credits, tvShowID: tvShowID, state: &state)

    case .fetchSeason(let seasonNumber, let tvShowID):
        return fetchSeason(seasonNumber: seasonNumber, tvShowID: tvShowID, environment: environment)

    case .setSeason(let season, let seasonNumber, let tvShowID):
        return setSeason(season: season, seasonNumber: seasonNumber, tvShowID: tvShowID, state: &state)
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

private func fetchNextTrendingIfNeeded(currentTVShow: TVShow, offset: Int,
                                       state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    let index = state.trendingIDs.firstIndex(where: { $0 == currentTVShow.id })
    let thresholdIndex = state.trendingIDs.index(state.trendingIDs.endIndex, offsetBy: -offset)
    guard index == thresholdIndex else {
        return Empty()
            .eraseToAnyPublisher()
    }

    return Just(.fetchTrending)
        .eraseToAnyPublisher()
}

private func appendTrending(tvShows: [TVShow], state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.isFetchingTrending = false
    guard !tvShows.isEmpty else {
        state.isMoreTrendingAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    var trendingIDs = state.trendingIDs
    tvShows.forEach {
        state.tvShows[$0.id] = $0
        if !trendingIDs.contains($0.id) {
            trendingIDs.append($0.id)
        }
    }
    state.trendingIDs = trendingIDs

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

private func fetchNextDiscoverIfNeeded(currentTVShow: TVShow, offset: Int,
                                       state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    let index = state.discoverIDs.firstIndex(where: { $0 == currentTVShow.id })
    let thresholdIndex = state.discoverIDs.index(state.discoverIDs.endIndex, offsetBy: -offset)
    guard index == thresholdIndex else {
        return Empty()
            .eraseToAnyPublisher()
    }

    return Just(.fetchDiscover)
        .eraseToAnyPublisher()
}

private func appendDiscover(tvShows: [TVShow], state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    state.isFetchingDiscover = false
    guard !tvShows.isEmpty else {
        state.isMoreDiscoverAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    var discoverIDs = state.discoverIDs
    tvShows.forEach {
        state.tvShows[$0.id] = $0
        if !discoverIDs.contains($0.id) {
            discoverIDs.append($0.id)
        }
    }
    state.discoverIDs = discoverIDs

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

private func fetchRecommendations(tvShowID: TVShow.ID, state: inout TVShowsState, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    return environment.tvShowsManager
        .fetchRecommendations(forTVShow: tvShowID)
        .map { .setRecommendations(recommendations: $0, tvShowID: tvShowID) }
        .eraseToAnyPublisher()
}

private func setRecommendations(recommendations: [TVShow], tvShowID: TVShow.ID, state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    var recommendationIDs = state.recommendationsIDs[tvShowID] ?? []
    recommendations.forEach {
        state.tvShows[$0.id] = $0
        if !recommendationIDs.contains($0.id) {
            recommendationIDs.append($0.id)
        }
    }
    state.recommendationsIDs[tvShowID] = recommendationIDs
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

private func fetchSeason(seasonNumber: Int, tvShowID: TVShow.ID, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
    environment.tvShowsManager
        .fetchSeason(seasonNumber, forTVShow: tvShowID)
        .filter { $0 != nil }
        .map { $0! }
        .map { .setSeason(season: $0, seasonNumber: seasonNumber, tvShowID: tvShowID) }
        .eraseToAnyPublisher()
}

private func setSeason(season: TVShowSeason, seasonNumber: Int, tvShowID: TVShow.ID, state: inout TVShowsState) -> AnyPublisher<TVShowsAction, Never> {
    var seasons = state.seasons[tvShowID] ?? [:]
    seasons[seasonNumber] = season
    state.seasons[tvShowID] = seasons

    return Empty()
        .eraseToAnyPublisher()
}
