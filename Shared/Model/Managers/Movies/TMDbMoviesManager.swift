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

    private let movieService: MovieService
    private let trendingService: TrendingService
    private let discoverService: DiscoverService

    init(
        movieService: MovieService = TMDbMovieService(),
        trendingService: TrendingService = TMDbTrendingService(),
        discoverService: DiscoverService = TMDbDiscoverService()
    ) {
        self.movieService = movieService
        self.trendingService = trendingService
        self.discoverService = discoverService
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[Movie], Never> {
        trendingService.fetchMovies(timeWindow: .day, page: page)
            .map(\.results)
            .map(Movie.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[Movie], Never> {
        discoverService.fetchMovies(page: page)
            .map(\.results)
            .map(Movie.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(forMovie movieID: Movie.ID) -> AnyPublisher<[Movie], Never> {
        movieService.fetchRecommendations(forMovie: movieID)
            .map(\.results)
            .map(Movie.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchMovie(withID id: Movie.ID) -> AnyPublisher<Movie?, Never> {
        movieService.fetchDetails(forMovie: id)
            .map(Movie.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchCredits(forMovie movieID: Movie.ID) -> AnyPublisher<Credits, Never> {
        movieService.fetchCredits(forMovie: movieID)
            .map(Credits.init)
            .replaceError(with: Credits())
            .eraseToAnyPublisher()
    }

}
