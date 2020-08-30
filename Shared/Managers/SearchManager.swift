//
//  SearchManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation
import TMDb

final class SearchManager: SearchManaging {

    private let searchService: SearchService

    init(searchService: SearchService = TMDbSearchService()) {
        self.searchService = searchService
    }

    func search(query: String) -> AnyPublisher<[MultiTypeListItem], Never> {
        searchService.searchAll(query: query)
            .map(\.results)
            .map(MultiTypeListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

}
