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

    private let tmdb: MovieTVShowAPI
    private var cancellables = Set<AnyCancellable>()

    init(tmdb: MovieTVShowAPI = TMDbAPI.shared) {
        self.tmdb = tmdb
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[TVShow], Never> {
        tmdb.trendingTVShowsPublisher(page: page)
            .map(\.results)
            .map(TVShow.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchTopTrending(completionHandler: @escaping (TVShow?) -> Void) {
        fetchTrending()
            .map(\.first)
            .replaceError(with: nil)
            .sink(receiveValue: completionHandler)
            .store(in: &cancellables)
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[TVShow], Never> {
        tmdb.discoverTVShowsPublisher(page: page)
            .map(\.results)
            .map(TVShow.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<[TVShow], Never> {
        tmdb.recommendationsPublisher(forTVShow: tvShowID)
            .map(\.results)
            .map(TVShow.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchTVShow(withID id: TVShow.ID) -> AnyPublisher<TVShow?, Never> {
        tmdb.detailsPublisher(forTVShow: id)
            .map(TVShow.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchCredits(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<Credits, Never> {
        tmdb.creditsPublisher(forTVShow: tvShowID)
            .map(Credits.init)
            .replaceError(with: Credits())
            .eraseToAnyPublisher()
    }

    func fetchSeason(_ seasonNumber: Int, forTVShow tvShowID: TVShow.ID) -> AnyPublisher<TVShowSeason?, Never> {
        tmdb.detailsPublisher(forSeason: seasonNumber, inTVShow: tvShowID)
            .map(TVShowSeason.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

}
