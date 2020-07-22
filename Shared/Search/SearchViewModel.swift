//
//  SearchViewModel.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {

    private let searchQueue = DispatchQueue.global(qos: .background)
    private var cancellables = Set<AnyCancellable>()

    @Published private var searchStore: SearchStorable

    @Published var searchText: String = ""
    @Published private(set) var isSearching = false
    @Published private(set) var results = [MultiTypeListItem]()

    init(searchStore: SearchStorable = SearchStore.shared) {
        self.searchStore = searchStore

        self.$searchText
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .debounce(for: 0.25, scheduler: self.searchQueue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: performSearch)
            .store(in: &cancellables)
    }

}

extension SearchViewModel {

    private func performSearch(query: String) {
        guard !query.isEmpty else {
            self.results = []
            return
        }

        isSearching = true

        searchStore.search(query: query)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isSearching = false
            }, receiveValue: { results in
                self.results = results
            })
            .store(in: &cancellables)
    }

}
