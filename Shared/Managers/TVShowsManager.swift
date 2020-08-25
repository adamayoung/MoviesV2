//
//  TVShowsManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation
import TMDb

protocol TVShowsManaging {

    func fetchTrending(page: Int) -> AnyPublisher<[TVShowListItem], Never>

    func fetchDiscover(page: Int) -> AnyPublisher<[TVShowListItem], Never>

    func fetchRecommendations(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<[TVShowListItem], Never>

    func fetchTVShow(withID id: TVShow.ID) -> AnyPublisher<TVShow?, Never>

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

final class TVShowsManager: TVShowsManaging {

    private let tvShowService: TVShowService
    private let creditsService: CreditsService

    init(tvShowService: TVShowService = TMDbTVShowService(), creditsService: CreditsService = TMDbCreditsService()) {
        self.tvShowService = tvShowService
        self.creditsService = creditsService
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[TVShowListItem], Never> {
        tvShowService.fetchTrending(timeWindow: .day, page: page)
            .map(\.results)
            .map(TVShowListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[TVShowListItem], Never> {
        tvShowService.fetchDiscover(page: page)
            .map(\.results)
            .map(TVShowListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<[TVShowListItem], Never> {
        tvShowService.fetchRecommendations(forTVShow: tvShowID)
            .map(\.results)
            .map(TVShowListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchTVShow(withID id: TVShow.ID) -> AnyPublisher<TVShow?, Never> {
        tvShowService.fetch(id: id)
            .map(TVShow.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchCredits(forTVShow tvShowID: TVShow.ID) -> AnyPublisher<Credits, Never> {
        creditsService.fetch(forTVShow: tvShowID)
            .map(Credits.init)
            .replaceError(with: Credits(id: tvShowID))
            .eraseToAnyPublisher()
    }

}
