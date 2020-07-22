//
//  TVShowDetailsViewModel.swift
//  Movies
//
//  Created by Adam Young on 17/07/2020.
//

import Combine
import Foundation

final class TVShowDetailsViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published private var tvShowStore: TVShowStorable
    @Published private var creditsStore: CreditsStorable
    private let id: TVShow.ID

    @Published private(set) var tvShow: TVShow?
    @Published private(set) var credits: Credits?

    init(id: TVShow.ID, tvShowStore: TVShowStorable = TVShowStore.shared,
         creditsStore: CreditsStorable = CreditsStore.shared) {
        self.id = id
        self.tvShowStore = tvShowStore
        self.creditsStore = creditsStore
    }

    func fetch() {
        guard tvShow == nil else {
            return
        }

        cancellables.forEach { $0.cancel() }
        fetchTVShow()
        fetchCredits()
    }

}

extension TVShowDetailsViewModel {

    private func fetchTVShow() {
        tvShowStore.tvShowPublisher(forID: id)
            .map { $0 as TVShow? }
            .receive(on: DispatchQueue.main)
            .assign(to: \.tvShow, on: self)
            .store(in: &cancellables)

        tvShowStore.fetchTVShow(withID: id)
    }

    private func fetchCredits() {
        creditsStore.tvShowCreditsPublisher(forTVShow: id)
            .map { $0 as Credits? }
            .receive(on: DispatchQueue.main)
            .assign(to: \.credits, on: self)
            .store(in: &cancellables)

        creditsStore.fetchCredits(forTVShow: id)
    }

}
