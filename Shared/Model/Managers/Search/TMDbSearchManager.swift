//
//  TMDbSearchManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation
import TMDb

final class TMDbSearchManager: SearchManager {

    private let tmdb: MovieTVShowAPI

    init(tmdb: MovieTVShowAPI = TMDbAPI.shared) {
        self.tmdb = tmdb
    }

    func search(query: String, page: Int = 1) -> AnyPublisher<[Media], Never> {
        tmdb.search.searchAllPublisher(query: query, page: page)
            .map(\.results)
            .map(Media.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

}
