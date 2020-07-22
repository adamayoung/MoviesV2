//
//  TVShowStore.swift
//  TVShows
//
//  Created by Adam Young on 15/07/2020.
//

import Combine
import Foundation
import TMDb

class BaseTVShowStore {

    @Published var trendingTVShows = [TVShowListItem]()
    @Published var isFetchingTrending = false
    @Published var discoverTVShows = [TVShowListItem]()
    @Published var isFetchingDiscover = false

}

protocol TVShowStorable: BaseTVShowStore {

    func fetchTrending()
    func fetchNextTrendingPageIfNeeded(currentTVShow id: TVShowListItem.ID)

    func fetchDiscover()
    func fetchNextDiscoverPageIfNeeded(currentTVShow id: TVShowListItem.ID)

    func fetchTVShow(withID id: TVShow.ID)
    func tvShowPublisher(forID id: TVShow.ID) -> AnyPublisher<TVShow, Never>

    func search(query: String) -> AnyPublisher<[TVShowListItem], Error>

}

final class TVShowStore: BaseTVShowStore, TVShowStorable, ObservableObject {

    private static let thresholdOffset = 15

    static let shared = TVShowStore()

    private let tvShowService: TVShowService

    private var cancellables = Set<AnyCancellable>()
    private var tvShowResults = [TVShowListItem.ID: TVShowListItem]()
    private var currentTrendingPage = 1
    private var canFetchMoreTrending = true
    private var currentDiscoverPage = 1
    private var canFetchMoreDiscover = true

    @Published private var trendingTVShowIDs = [TVShowListItem.ID]()
    @Published private var discoverTVShowIDs = [TVShowListItem.ID]()
    @Published private var tvShows = [TVShow.ID: TVShow]()

    init(tvShowService: TVShowService = TMDbTVShowService()) {
        self.tvShowService = tvShowService
        super.init()

        $trendingTVShowIDs
            .removeDuplicates()
            .map { $0.compactMap { self.tvShowResults[$0] } }
            .assign(to: \.trendingTVShows, on: self)
            .store(in: &cancellables)

        $discoverTVShowIDs
            .removeDuplicates()
            .map { $0.compactMap { self.tvShowResults[$0] } }
            .assign(to: \.discoverTVShows, on: self)
            .store(in: &cancellables)

        fetchTrending()
        fetchDiscover()
    }

    func fetchTrending() {
        guard canFetchMoreTrending, !isFetchingTrending else {
            return
        }

        isFetchingTrending = true

        tvShowService.fetchTrending(timeWindow: .day, page: currentTrendingPage)
            .catch { _ in
                Empty<TVShowPageableListResult, Never>()
            }
            .map(\.results)
            .map { TVShowListItem.create(tvShows: $0) }
            .sink(receiveCompletion: { _ in
                self.isFetchingTrending = false
            }, receiveValue: { tvShows in
                self.mergeTrendingTVShows(tvShows)
                self.currentTrendingPage += 1
                self.canFetchMoreTrending = !tvShows.isEmpty
            })
            .store(in: &cancellables)
    }

    func fetchNextTrendingPageIfNeeded(currentTVShow id: TVShowListItem.ID) {
        let thresholdIndex = trendingTVShowIDs.index(trendingTVShowIDs.endIndex, offsetBy: -Self.thresholdOffset)
        guard trendingTVShowIDs.firstIndex(where: { $0 == id }) == thresholdIndex else {
            return
        }

        fetchTrending()
    }

    func fetchDiscover() {
        guard canFetchMoreDiscover, !isFetchingDiscover else {
            return
        }

        isFetchingDiscover = true

        tvShowService.fetchDiscover(page: currentDiscoverPage)
            .catch { _ in
                Empty<TVShowPageableListResult, Never>()
            }
            .map(\.results)
            .map { TVShowListItem.create(tvShows: $0) }
            .sink(receiveCompletion: { _ in
                self.isFetchingDiscover = false
            }, receiveValue: { tvShows in
                self.mergeDiscoverTVShows(tvShows)
                self.currentDiscoverPage += 1
                self.canFetchMoreDiscover = !tvShows.isEmpty
            })
            .store(in: &cancellables)
    }

    func fetchNextDiscoverPageIfNeeded(currentTVShow id: TVShowListItem.ID) {
        let thresholdIndex = discoverTVShowIDs.index(discoverTVShowIDs.endIndex, offsetBy: -Self.thresholdOffset)
        guard discoverTVShowIDs.firstIndex(where: { $0 == id }) == thresholdIndex else {
            return
        }

        fetchDiscover()
    }

    func fetchTVShow(withID id: TVShow.ID) {
        guard tvShows[id] == nil else {
            return
        }

        tvShowService.fetch(id: id)
            .map { TVShow(tvShow: $0) }
            .catch { _ in
                Empty<TVShow, Never>()
            }
            .sink(receiveCompletion: { _ in
            }, receiveValue: { tvShow in
                var tvShows = self.tvShows
                tvShows[tvShow.id] = tvShow
                self.tvShows = tvShows
            })
            .store(in: &cancellables)
    }

    func tvShowPublisher(forID id: TVShow.ID) -> AnyPublisher<TVShow, Never> {
        $tvShows
            .map { $0[id] }
            .filter { $0 != nil }
            .map { $0! }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func search(query: String) -> AnyPublisher<[TVShowListItem], Error> {
        tvShowService.search(query: query)
            .mapError { $0 as Error }
            .map(\.results)
            .map(TVShowListItem.create)
            .eraseToAnyPublisher()
    }

}

extension TVShowStore {

    private func mergeTrendingTVShows(_ tvShows: [TVShowListItem]) {
        tvShows.forEach { tvShow in
            self.tvShowResults[tvShow.id] = tvShow
            var trendingTVShowIDs = self.trendingTVShowIDs
            if !trendingTVShowIDs.contains(tvShow.id) {
                trendingTVShowIDs.append(tvShow.id)
            }

            self.trendingTVShowIDs = trendingTVShowIDs
        }
    }

    private func mergeDiscoverTVShows(_ tvShows: [TVShowListItem]) {
        tvShows.forEach { tvShow in
            self.tvShowResults[tvShow.id] = tvShow
            var discoverTVShowIDs = self.discoverTVShowIDs
            if !discoverTVShowIDs.contains(tvShow.id) {
                discoverTVShowIDs.append(tvShow.id)
            }

            self.discoverTVShowIDs = discoverTVShowIDs
        }
    }

}
