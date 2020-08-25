//
//  SearchManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation
import TMDb

protocol SearchManaging {

    func search(query: String) -> AnyPublisher<[MultiTypeListItem], Never>
}

final class SearchManager: SearchManaging {

    private let searchService: MultiSearchService

    init(searchService: MultiSearchService = TMDbMultiSearchService()) {
        self.searchService = searchService
    }

    func search(query: String) -> AnyPublisher<[MultiTypeListItem], Never> {
        searchService.search(query: query)
            .map(\.results)
            .map(MultiTypeListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

}
