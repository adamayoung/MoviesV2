//
//  SearchReducer.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation

func searchReducer(state: inout SearchState, action: SearchAction, environment: AppEnvironment) -> AnyPublisher<SearchAction, Never> {
    switch action {
    case .search(let query):
        guard !query.isEmpty else {
            state.results = []
            break
        }

        state.query = query
        state.isSearching = true

        return environment.searchManager
            .search(query: query)
            .map { .setResults(results: $0, query: query) }
            .eraseToAnyPublisher()

    case .setResults(let results, let query):
        guard query == state.query else {
            break
        }

        state.results = results
        state.isSearching = false
    }

    return Empty().eraseToAnyPublisher()
}
