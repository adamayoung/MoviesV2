//
//  HomeViewModel.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Combine
import Foundation
import TMDb

final class HomeViewModel: ObservableObject {

    private static let maxCarouselItems = 10

    private var cancellables = Set<AnyCancellable>()

    @Published private var movieStore: MovieStorable
    @Published private var tvShowStore: TVShowStorable

    @Published private(set) var trendingMovies = [MovieListItem]()
    @Published private(set) var discoverMovies = [MovieListItem]()
    @Published private(set) var trendingTVShows = [TVShowListItem]()
    @Published private(set) var discoverTVShows = [TVShowListItem]()

    init(movieStore: MovieStorable = MovieStore.shared, tvShowStore: TVShowStorable = TVShowStore.shared) {
        self.movieStore = movieStore
        self.tvShowStore = tvShowStore

        self.movieStore.$trendingMovies
            .map { Array($0.prefix(Self.maxCarouselItems)) }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.trendingMovies, on: self)
            .store(in: &cancellables)

        self.movieStore.$discoverMovies
            .map { Array($0.prefix(Self.maxCarouselItems)) }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.discoverMovies, on: self)
            .store(in: &cancellables)

        self.tvShowStore.$trendingTVShows
            .map { Array($0.prefix(Self.maxCarouselItems)) }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.trendingTVShows, on: self)
            .store(in: &cancellables)

        self.tvShowStore.$discoverTVShows
            .map { Array($0.prefix(Self.maxCarouselItems)) }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.discoverTVShows, on: self)
            .store(in: &cancellables)
    }

}
