//
//  TVShowsManager.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol TVShowsManager {

    func fetchTrending(page: Int) -> AnyPublisher<[TVShow], Never>

    func fetchTopTrending(completionHandler: @escaping (TVShow?) -> Void)

    func fetchDiscover(page: Int) -> AnyPublisher<[TVShow], Never>

    func fetchRecommendations(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<[TVShow], Never>

    func fetchTVShow(withID id: TVShow.ID) -> AnyPublisher<TVShow?, Never>

    func fetchCredits(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<Credits, Never>

    func fetchSeason(_ seasonNumber: Int, forTVShow tvShowID: TVShow.ID) -> AnyPublisher<TVShowSeason?, Never>

}

extension TVShowsManager {

    func fetchTrending(page: Int = 1) -> AnyPublisher<[TVShow], Never> {
        fetchTrending(page: page)
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[TVShow], Never> {
        fetchDiscover(page: page)
    }

}
