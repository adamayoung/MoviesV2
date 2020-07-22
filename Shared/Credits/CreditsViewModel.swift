//
//  CreditsViewModel.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Combine
import Foundation

final class CreditsViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published private var store: CreditsStorable
    private let movieID: Movie.ID?
    private let tvShowID: TVShow.ID?

    @Published private(set) var credits: Credits?

    init(movieID: Movie.ID, store: CreditsStorable = CreditsStore.shared) {
        self.movieID = movieID
        self.tvShowID = nil
        self.store = store
    }

    init(tvShowID: TVShow.ID, store: CreditsStorable = CreditsStore.shared) {
        self.tvShowID = tvShowID
        self.movieID = nil
        self.store = store
    }

    func fetch() {
        guard credits == nil else {
            return
        }

        cancellables.forEach { $0.cancel() }

        if let movieID = movieID {
            store.movieCreditsPublisher(forMovie: movieID)
                .map { $0 as Credits? }
                .receive(on: DispatchQueue.main)
                .assign(to: \.credits, on: self)
                .store(in: &cancellables)

            store.fetchCredits(forMovie: movieID)
        }

        if let tvShowID = tvShowID {
            store.tvShowCreditsPublisher(forTVShow: tvShowID)
                .map { $0 as Credits? }
                .receive(on: DispatchQueue.main)
                .assign(to: \.credits, on: self)
                .store(in: &cancellables)

            store.fetchCredits(forTVShow: tvShowID)
        }
    }

}
