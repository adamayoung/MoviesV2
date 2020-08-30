//
//  TVShowsManaging.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol TVShowsManaging {

    func fetchTrending(page: Int) -> AnyPublisher<[TVShowListItem], Never>

    func fetchDiscover(page: Int) -> AnyPublisher<[TVShowListItem], Never>

    func fetchRecommendations(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<[TVShowListItem], Never>

    func fetchTVShow(withID id: TVShow.ID) -> AnyPublisher<TVShow?, Never>

    func fetchTVShowExtended(withID id: TVShow.ID) -> AnyPublisher<TVShowExtended?, Never>

    func fetchCredits(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<Credits, Never>

}

extension TVShowsManaging {

    func fetchTrending(page: Int = 1) -> AnyPublisher<[TVShowListItem], Never> {
        fetchTrending(page: page)
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[TVShowListItem], Never> {
        fetchDiscover(page: page)
    }

}
