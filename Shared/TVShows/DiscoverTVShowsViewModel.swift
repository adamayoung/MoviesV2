//
//  DiscoverTVShowsViewModel.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Combine
import Foundation

final class DiscoverTVShowsViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published private var store: TVShowStorable

    @Published private(set) var tvShows = [TVShowListItem]()
    @Published private(set) var isFetching = false

    init(store: TVShowStorable = TVShowStore.shared) {
        self.store = store

        self.store.$discoverTVShows
            .receive(on: DispatchQueue.main)
            .assign(to: \.tvShows, on: self)
            .store(in: &cancellables)

        self.store.$isFetchingDiscover
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFetching, on: self)
            .store(in: &cancellables)
    }

    func fetchNextPageIfNeeded(currentTVShow id: TVShowListItem.ID) {
        store.fetchNextDiscoverPageIfNeeded(currentTVShow: id)
    }

}
