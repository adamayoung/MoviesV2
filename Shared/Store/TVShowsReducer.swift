//
//  TVShowsReducer.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

func tvShowsReducer(state: inout TVShowsState, action: TVShowsAction, environment: AppEnvironment) -> AnyPublisher<TVShowsAction, Never> {
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

        return environment.tvShowsManager
            .fetchTrending(page: state.currentTrendingPage)
            .map { .setTrending(tvShows: $0) }
            .eraseToAnyPublisher()

    case .setTrending(let tvShows):
        state.isFetchingTrending = false
        guard !tvShows.isEmpty else {
            state.isMoreTrendingAvailable = false
            break
        }

        mergeTrending(tvShows, into: &state)

    case .fetchDiscover:
        guard !state.isFetchingDiscover else {
            break
        }

        guard state.isMoreDiscoverAvailable else {
            break
        }

        state.isFetchingDiscover = true
        state.currentDiscoverPage += 1

        return environment.tvShowsManager
            .fetchDiscover(page: state.currentDiscoverPage)
            .map { .setDiscover(tvShows: $0) }
            .eraseToAnyPublisher()

    case .setDiscover(let tvShows):
        state.isFetchingDiscover = false
        guard !tvShows.isEmpty else {
            state.isMoreDiscoverAvailable = false
            break
        }

        mergeDiscover(tvShows, into: &state)

    case .fetch(let id):
        return environment.tvShowsManager
            .fetchTVShow(withID: id)
            .filter { $0 != nil }
            .map { $0! }
            .map { .appendTVShow(tvShow: $0) }
            .eraseToAnyPublisher()

    case .appendTVShow(let tvShow):
        state.tvShows[tvShow.id] = tvShow

    case .fetchRecommendations(let tvShowID):
        return environment.tvShowsManager
            .fetchRecommendations(forTVShow: tvShowID)
            .map { .setRecommendations(recommendations: $0, tvShowID: tvShowID) }
            .eraseToAnyPublisher()

    case .setRecommendations(let recommendations, let tvShowID):
        state.recommendations[tvShowID] = recommendations

    case .fetchCredits(let tvShowID):
        return environment.tvShowsManager
            .fetchCredits(forTVShow: tvShowID)
            .map { .setCredits(credits: $0, tvShowID: tvShowID) }
            .eraseToAnyPublisher()

    case .setCredits(let credits, let tvShowID):
        state.credits[tvShowID] = credits
    }

    return Empty().eraseToAnyPublisher()
}

fileprivate func mergeTrending(_ tvShows: [TVShowListItem], into state: inout TVShowsState) {
    tvShows.forEach {
        state.tvShowList[$0.id] = $0
    }

    state.trendingIDs.append(contentsOf: tvShows.map(\.id))
}

fileprivate func mergeDiscover(_ tvShows: [TVShowListItem], into state: inout TVShowsState) {
    tvShows.forEach {
        state.tvShowList[$0.id] = $0
    }

    state.discoverIDs.append(contentsOf: tvShows.map(\.id))
}
