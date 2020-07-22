//
//  CreditsStore.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Combine
import Foundation
import TMDb

class BaseCreditsStore {

}

protocol CreditsStorable: BaseCreditsStore {

    func fetchCredits(forMovie movieID: Movie.ID)
    func movieCreditsPublisher(forMovie id: Movie.ID) -> AnyPublisher<Credits, Never>
    func fetchCredits(forTVShow tvShowID: TVShow.ID)
    func tvShowCreditsPublisher(forTVShow id: TVShow.ID) -> AnyPublisher<Credits, Never>

}

final class CreditsStore: BaseCreditsStore, CreditsStorable, ObservableObject {

    static let shared = CreditsStore()

    private let creditsService: CreditsService

    private var cancellables = Set<AnyCancellable>()

    @Published private var movieCredits = [Credits.ID: Credits]()
    @Published private var tvShowCredits = [Credits.ID: Credits]()

    init(creditsService: CreditsService = TMDbCreditsService()) {
        self.creditsService = creditsService
        super.init()
    }

    func fetchCredits(forMovie movieID: Movie.ID) {
        creditsService.fetch(forMovie: movieID)
            .map(Credits.init)
            .catch { _ in
                Empty<Credits, Never>()
            }
            .sink(receiveCompletion: { _ in
            }, receiveValue: { credits in
                var movieCredits = self.movieCredits
                movieCredits[credits.id] = credits
                self.movieCredits = movieCredits
            })
            .store(in: &cancellables)
    }

    func movieCreditsPublisher(forMovie id: Movie.ID) -> AnyPublisher<Credits, Never> {
        $movieCredits
            .map { $0[id] }
            .filter { $0 != nil }
            .map { $0! }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func fetchCredits(forTVShow tvShowID: TVShow.ID) {
        creditsService.fetch(forTVShow: tvShowID)
            .map(Credits.init)
            .catch { _ in
                Empty<Credits, Never>()
            }
            .sink(receiveCompletion: { _ in
            }, receiveValue: { credits in
                var tvShowCredits = self.tvShowCredits
                tvShowCredits[credits.id] = credits
                self.tvShowCredits = tvShowCredits
            })
            .store(in: &cancellables)
    }

    func tvShowCreditsPublisher(forTVShow id: TVShow.ID) -> AnyPublisher<Credits, Never> {
        $tvShowCredits
            .map { $0[id] }
            .filter { $0 != nil }
            .map { $0! }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

}
