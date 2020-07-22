//
//  TrendingTVShowsViewModel.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Combine
import Foundation

final class TrendingTVShowsViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published private var store: TVShowStorable

    @Published private(set) var tvShows = [TVShowListItem]()
    @Published private(set) var isFetching = false

    init(store: TVShowStorable = TVShowStore.shared) {
        self.store = store

        self.store.$trendingTVShows
            .receive(on: DispatchQueue.main)
            .assign(to: \.tvShows, on: self)
            .store(in: &cancellables)

        self.store.$isFetchingTrending
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFetching, on: self)
            .store(in: &cancellables)
    }

    func fetchNextPageIfNeeded(currentTVShow id: TVShowListItem.ID) {
        store.fetchNextTrendingPageIfNeeded(currentTVShow: id)
    }

}
