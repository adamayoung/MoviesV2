//
//  SearchStore.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import Combine
import Foundation

final class SearchStore: ObservableObject {

    @Published var results: [Media] = []

    private let searchManager: SearchManager

    private var cancellables = Set<AnyCancellable>()

    init(searchManager: SearchManager = TMDbSearchManager()) {
        self.searchManager = searchManager
    }

    func search(query: String, completionHandler: ((Error?) -> Void)? = nil) {
        cancellables.forEach { $0.cancel() }

        guard !query.isEmpty else {
            results = []
            return
        }

        searchManager.search(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] media in
                self?.results = media
            })
            .store(in: &cancellables)
    }

}
