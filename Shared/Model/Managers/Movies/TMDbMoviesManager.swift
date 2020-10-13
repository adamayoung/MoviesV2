//
//  TMDbMoviesManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import CloudKit
import Combine
import Foundation
import TMDb

final class TMDbMoviesManager: MoviesManager {

    private let tmdb: MovieTVShowAPI
    private var cancellables = Set<AnyCancellable>()

    init(tmdb: MovieTVShowAPI = TMDbAPI.shared) {
        self.tmdb = tmdb
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[Movie], Never> {
        tmdb.trendingMoviesPublisher(page: page)
            .map(\.results)
            .map(Movie.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchTopTrending(completionHandler: @escaping (Movie?) -> Void) {
        fetchTrending()
            .map(\.first)
            .replaceError(with: nil)
            .sink(receiveValue: completionHandler)
            .store(in: &cancellables)
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[Movie], Never> {
        tmdb.discoverMoviesPublisher(page: page)
            .map(\.results)
            .map(Movie.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(forMovie movieID: Movie.ID) -> AnyPublisher<[Movie], Never> {
        tmdb.recommendationsPublisher(forMovie: movieID)
            .map(\.results)
            .map(Movie.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchMovie(withID id: Movie.ID) -> AnyPublisher<Movie?, Never> {
        tmdb.detailsPublisher(forMovie: id)
            .map(Movie.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchCredits(forMovie movieID: Movie.ID) -> AnyPublisher<Credits, Never> {
        tmdb.creditsPublisher(forMovie: movieID)
            .map(Credits.init)
            .replaceError(with: Credits())
            .eraseToAnyPublisher()
    }

}
