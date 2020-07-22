//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import Combine
import Foundation

final class MovieDetailsViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published private var movieStore: MovieStorable
    @Published private var creditsStore: CreditsStorable
    private let id: Movie.ID

    @Published private(set) var movie: Movie?
    @Published private(set) var credits: Credits?
    @Published private(set) var recommendations: [MovieListItem]?

    init(id: Movie.ID, movieStore: MovieStorable = MovieStore.shared,
         creditsStore: CreditsStorable = CreditsStore.shared) {
        self.id = id
        self.movieStore = movieStore
        self.creditsStore = creditsStore
    }

    func fetch() {
        guard movie == nil else {
            return
        }

        cancellables.forEach { $0.cancel() }
        fetchMovie()
        fetchCredits()
        fetchRecommenations()
    }

}

extension MovieDetailsViewModel {

    private func fetchMovie() {
        movieStore.moviePublisher(forID: id)
            .map { $0 as Movie? }
            .receive(on: DispatchQueue.main)
            .assign(to: \.movie, on: self)
            .store(in: &cancellables)

        movieStore.fetchMovie(withID: id)
    }

    private func fetchCredits() {
        creditsStore.movieCreditsPublisher(forMovie: id)
            .map { $0 as Credits? }
            .receive(on: DispatchQueue.main)
            .assign(to: \.credits, on: self)
            .store(in: &cancellables)

        creditsStore.fetchCredits(forMovie: id)
    }

    private func fetchRecommenations() {
        movieStore.recommendationsPublisher(forMovie: id)
            .map { $0 as [MovieListItem]? }
            .receive(on: DispatchQueue.main)
            .assign(to: \.recommendations, on: self)
            .store(in: &cancellables)

        movieStore.fetchRecommendations(forMovie: id)
    }

}
