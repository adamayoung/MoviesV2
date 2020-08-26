//
//  AppReduxStore.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

func appReducer(state: inout AppState, action: AppAction, environment: AppEnvironment) -> AnyPublisher<AppAction, Never> {
    switch action {
    case .movies(let action):
        return moviesReducer(state: &state.movies, action: action, environment: environment)
            .map { .movies($0) }
            .eraseToAnyPublisher()

    case .tvShows(let action):
        return tvShowsReducer(state: &state.tvShows, action: action, environment: environment)
            .map { .tvShows($0) }
            .eraseToAnyPublisher()

    case .search(let action):
        return searchReducer(state: &state.search, action: action, environment: environment)
            .map { .search($0) }
            .eraseToAnyPublisher()
    }
}
