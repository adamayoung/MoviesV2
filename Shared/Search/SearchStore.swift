//
//  SearchStore.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Combine
import Foundation
import TMDb

class BaseSearchStore {

    @Published var trendingTVShows = [TVShowListItem]()
    @Published var isFetchingTrending = false
    @Published var discoverTVShows = [TVShowListItem]()
    @Published var isFetchingDiscover = false

}

protocol SearchStorable: BaseSearchStore {

    func search(query: String) -> AnyPublisher<[MultiTypeListItem], Error>

}

final class SearchStore: BaseSearchStore, SearchStorable, ObservableObject {

    private static let thresholdOffset = 15

    static let shared = SearchStore()

    private let multiSearchService: MultiSearchService

    private var cancellables = Set<AnyCancellable>()

    init(multiSearchService: MultiSearchService = TMDbMultiSearchService()) {
        self.multiSearchService = multiSearchService
        super.init()
    }

    func search(query: String) -> AnyPublisher<[MultiTypeListItem], Error> {
        multiSearchService.search(query: query)
            .mapError { $0 as Error }
            .map(\.results)
            .map(MultiTypeListItem.create)
            .eraseToAnyPublisher()
    }

}
