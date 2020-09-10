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

    private let searchService: SearchService

    init(searchService: SearchService = TMDbSearchService()) {
        self.searchService = searchService
    }

    func search(query: String) -> AnyPublisher<[Media], Never> {
        searchService.searchAll(query: query)
            .map(\.results)
            .map(Media.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

}
