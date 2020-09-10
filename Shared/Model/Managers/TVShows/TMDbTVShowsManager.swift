//
//  TMDbTVShowsManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation
import TMDb

final class TMDbTVShowsManager: TVShowsManager {

    private let tvShowService: TVShowService
    private let trendingService: TrendingService
    private let discoverService: DiscoverService

    init(
        tvShowService: TVShowService = TMDbTVShowService(),
        trendingService: TrendingService = TMDbTrendingService(),
        discoverService: DiscoverService = TMDbDiscoverService()
    ) {
        self.tvShowService = tvShowService
        self.trendingService = trendingService
        self.discoverService = discoverService
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[TVShow], Never> {
        trendingService.fetchTVShows(timeWindow: .day, page: page)
            .map(\.results)
            .map(TVShow.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[TVShow], Never> {
        discoverService.fetchTVShows(page: page)
            .map(\.results)
            .map(TVShow.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<[TVShow], Never> {
        tvShowService.fetchRecommendations(forTVShow: tvShowID)
            .map(\.results)
            .map(TVShow.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchTVShow(withID id: TVShow.ID) -> AnyPublisher<TVShow?, Never> {
        tvShowService.fetchDetails(forTVShow: id)
            .map(TVShow.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchCredits(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<Credits, Never> {
        tvShowService.fetchCredits(forTVShow: tvShowID)
            .map(Credits.init)
            .replaceError(with: Credits())
            .eraseToAnyPublisher()
    }

}
