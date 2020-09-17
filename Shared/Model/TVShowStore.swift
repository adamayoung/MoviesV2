//
//  TVShowStore.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import Combine
import Foundation

final class TVShowStore: ObservableObject {

    private static let topLimit = 10

    var trending: [TVShow] {
        trendingIDs.compactMap { tvShows[$0] }
    }

    var topTrending: [TVShow] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { tvShows[$0] }
    }

    var discover: [TVShow] {
        discoverIDs.compactMap { tvShows[$0] }
    }

    var topDiscover: [TVShow] {
        Array(discoverIDs.prefix(Self.topLimit))
            .compactMap { tvShows[$0] }
    }

    private let tvShowsManager: TVShowsManager

    @Published private var tvShows: [TVShow.ID: TVShow] = [:]
    @Published private var trendingIDs: [TVShow.ID] = []
    @Published private var discoverIDs: [TVShow.ID] = []
    @Published private var seasons: [TVShow.ID: [Int: TVShowSeason]] = [:]
    @Published private var recommendationsIDs: [TVShow.ID: [TVShow.ID]] = [:]
    @Published private var credits: [TVShow.ID: Credits] = [:]

    private var cancellables = Set<AnyCancellable>()
    private var isFetchingTrending = false
    private var currentTrendingPage = 0
    private var isMoreTrendingAvailable = true
    private var isFetchingDiscover = false
    private var currentDiscoverPage = 0
    private var isMoreDiscoverAvailable = true

    init(tvShowsManager: TVShowsManager = TMDbTVShowsManager()) {
        self.tvShowsManager = tvShowsManager
    }

    func tvShow(withID id: TVShow.ID) -> TVShow? {
        tvShows[id]
    }

    func seasons(forTVShow tvShowID: TVShow.ID) -> [TVShowSeason]? {
        tvShows[tvShowID]?.seasons
    }

    func season(_ seasonNumber: Int, forTVShow tvShowID: TVShow.ID) -> TVShowSeason? {
        seasons[tvShowID]?[seasonNumber]
    }

    func credits(forTVShow tvShowID: TVShow.ID) -> Credits? {
        credits[tvShowID]
    }

    func recommendations(forTVShow tvShowID: TVShow.ID) -> [TVShow]? {
        recommendationsIDs[tvShowID]?.compactMap { tvShows[$0] }
    }

}

extension TVShowStore {

    func fetchTrending(completionHandler: ((Error?) -> Void)? = nil) {
        guard !isFetchingTrending, isMoreTrendingAvailable else {
            completionHandler?(nil)
            return
        }

        isFetchingTrending = true
        currentTrendingPage += 1

        return tvShowsManager.fetchTrending(page: currentTrendingPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetchingTrending = false

                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] tvShows in
                guard !tvShows.isEmpty else {
                    self?.isMoreTrendingAvailable = false
                    return
                }

                self?.appendTrending(tvShows: tvShows)
            })
            .store(in: &cancellables)
    }

    func fetchNextTrendingIfNeeded(currentTVShow: TVShow, offset: Int, completionHandler: ((Error?) -> Void)? = nil) {
        let index = trendingIDs.firstIndex(where: { $0 == currentTVShow.id })
        let thresholdIndex = trendingIDs.index(trendingIDs.endIndex, offsetBy: -offset)
        guard index == thresholdIndex else {
            completionHandler?(nil)
            return
        }

        fetchTrending(completionHandler: completionHandler)
    }

    func fetchDiscover(completionHandler: ((Error?) -> Void)? = nil) {
        guard !isFetchingDiscover, isMoreDiscoverAvailable else {
            completionHandler?(nil)
            return
        }

        isFetchingDiscover = true
        currentDiscoverPage += 1

        return tvShowsManager.fetchDiscover(page: currentDiscoverPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetchingDiscover = false

                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] tvShows in
                guard !tvShows.isEmpty else {
                    self?.isMoreDiscoverAvailable = false
                    return
                }

                self?.appendDiscover(tvShows: tvShows)
            })
            .store(in: &cancellables)
    }

    func fetchNextDiscoverIfNeeded(currentTVShow: TVShow, offset: Int, completionHandler: ((Error?) -> Void)? = nil) {
        let index = discoverIDs.firstIndex(where: { $0 == currentTVShow.id })
        let thresholdIndex = discoverIDs.index(discoverIDs.endIndex, offsetBy: -offset)
        guard index == thresholdIndex else {
            completionHandler?(nil)
            return
        }

        fetchDiscover(completionHandler: completionHandler)
    }

    func fetchTVShow(withID id: TVShow.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard tvShows[id]?.seasons == nil else {
            completionHandler?(nil)
            return
        }

        tvShowsManager.fetchTVShow(withID: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] tvShow in
                guard let tvShow = tvShow else {
                    return
                }

                self?.tvShows[tvShow.id] = tvShow
            })
            .store(in: &cancellables)
    }

    func fetchCredits(forTVShow tvShowID: TVShow.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard credits[tvShowID] == nil else {
            completionHandler?(nil)
            return
        }

        tvShowsManager.fetchCredits(forTVShow: tvShowID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] credits in
                self?.credits[tvShowID] = credits
            })
            .store(in: &cancellables)
    }

    func fetchRecommendations(forTVShow tvShowID: Movie.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard recommendations(forTVShow: tvShowID) == nil else {
            completionHandler?(nil)
            return
        }

        tvShowsManager.fetchRecommendations(forTVShow: tvShowID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] recommendations in
                var recommendationIDs = self?.recommendationsIDs[tvShowID] ?? []
                recommendations.forEach {
                    self?.tvShows[$0.id] = $0
                    recommendationIDs.append($0.id)
                }
                self?.recommendationsIDs[tvShowID] = recommendationIDs
            })
            .store(in: &cancellables)
    }

    func fetchSeason(_ seasonNumber: Int, forTVShow tvShowID: TVShow.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard seasons[tvShowID] == nil else {
            return
        }

        tvShowsManager.fetchSeason(seasonNumber, forTVShow: tvShowID)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] season in
                var seasons = self?.seasons[tvShowID] ?? [:]
                seasons[seasonNumber] = season
                self?.seasons[tvShowID] = seasons
            })
            .store(in: &cancellables)
    }

}

extension TVShowStore {

    private func appendTrending(tvShows: [TVShow]) {
        var trendingIDs = self.trendingIDs
        tvShows.forEach {
            self.tvShows[$0.id] = $0
            if !trendingIDs.contains($0.id) {
                trendingIDs.append($0.id)
            }
        }
        self.trendingIDs = trendingIDs
    }

    private func appendDiscover(tvShows: [TVShow]) {
        var discoverIDs = self.discoverIDs
        tvShows.forEach {
            self.tvShows[$0.id] = $0
            if !discoverIDs.contains($0.id) {
                discoverIDs.append($0.id)
            }
        }
        self.discoverIDs = discoverIDs
    }

}
