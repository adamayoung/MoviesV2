//
//  MoviesManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import CloudKit
import Foundation
import TMDb

final class TMDbMoviesManager: MoviesManaging {

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

    func fetchTrending(page: Int = 1) -> AnyPublisher<[MovieListItem], Never> {
        trendingService.fetchMovies(timeWindow: .day, page: page)
            .map(\.results)
            .map(MovieListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[MovieListItem], Never> {
        discoverService.fetchMovies(page: page)
            .map(\.results)
            .map(MovieListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(forMovie movieID: Movie.ID) -> AnyPublisher<[MovieListItem], Never> {
        movieService.fetchRecommendations(forMovie: movieID)
            .map(\.results)
            .map(MovieListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchMovie(withID id: Movie.ID) -> AnyPublisher<Movie?, Never> {
        movieService.fetchDetails(forMovie: id)
            .map(Movie.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchMovieExtended(withID id: Movie.ID) -> AnyPublisher<MovieExtended?, Never> {
        movieService.fetchDetails(forMovie: id, include: [.credits, .recommendations])
            .map(MovieExtended.init)
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
