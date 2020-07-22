//
//  TrendingMoviesViewModel.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Combine
import Foundation

final class TrendingMoviesViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published private var store: MovieStorable

    @Published private(set) var movies = [MovieListItem]()
    @Published private(set) var isFetching = false

    init(store: MovieStorable = MovieStore.shared) {
        self.store = store

        self.store.$trendingMovies
            .receive(on: DispatchQueue.main)
            .assign(to: \.movies, on: self)
            .store(in: &cancellables)

        self.store.$isFetchingTrending
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFetching, on: self)
            .store(in: &cancellables)
    }

    func fetchNextPageIfNeeded(currentMovie id: MovieListItem.ID) {
        store.fetchNextTrendingPageIfNeeded(currentMovie: id)
    }

}
