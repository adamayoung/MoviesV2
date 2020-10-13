//
//  SearchStore.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import Combine
import Foundation

final class SearchStore: ObservableObject {

    @Published var results: [Media]?
    @Published var isSearching = false

    private let searchManager: SearchManager

    @Published private var query: String = ""
    private var currentPage = 1
    private var isFetchingResults = false
    private var isResultsAvailable = true
    private var cancellables = Set<AnyCancellable>()

    init(searchManager: SearchManager = TMDbSearchManager()) {
        self.searchManager = searchManager

        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isSearching = true
                self?.currentPage = 1
                self?.isResultsAvailable = true
            })
            .flatMap { query -> AnyPublisher<[Media]?, Never> in
                if query.isEmpty {
                    return Just(nil)
                        .eraseToAnyPublisher()
                }

                return searchManager.search(query: query)
                    .map { Optional($0) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isSearching = false
            })
            .assign(to: \.results, on: self)
            .store(in: &cancellables)
    }

    func search(query: String) {
        self.query = query
    }

    func fetchNextPageIfNeeded(currentMediaItem: Media, offset: Int, completionHandler: ((Error?) -> Void)? = nil) {
        guard isResultsAvailable else {
            completionHandler?(nil)
            return
        }

        guard let results = self.results else {
            completionHandler?(nil)
            return
        }

        let resultIDs = results.map(\.id)
        let index = resultIDs.firstIndex(where: { $0 == currentMediaItem.id })
        let thresholdIndex = resultIDs.index(resultIDs.endIndex, offsetBy: -offset)
        guard index == thresholdIndex else {
            completionHandler?(nil)
            return
        }

        guard !isFetchingResults else {
            completionHandler?(nil)
            return
        }

        currentPage += 1
        isFetchingResults = true
        searchManager.search(query: query, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetchingResults = false

                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] media in
                guard !media.isEmpty, let results = self?.results else {
                    self?.isResultsAvailable = false
                    return
                }

                self?.results = results + media
            })
            .store(in: &cancellables)
    }

}
