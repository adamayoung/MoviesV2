//
//  MoviesManager.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Combine
import Foundation
import TMDb

protocol MoviesManaging {

    func fetchTrending(page: Int) -> AnyPublisher<[MovieListItem], Never>

    func fetchDiscover(page: Int) -> AnyPublisher<[MovieListItem], Never>

    func fetchRecommendations(forMovie movieID: Movie.ID) -> AnyPublisher<[MovieListItem], Never>

    func fetchMovie(withID id: Movie.ID) -> AnyPublisher<Movie?, Never>

    func fetchCredits(forMovie movieID: Movie.ID) -> AnyPublisher<Credits, Never>

}

extension MoviesManaging {

    func fetchTrending(page: Int = 1) -> AnyPublisher<[MovieListItem], Never> {
        fetchTrending(page: page)
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[MovieListItem], Never> {
        fetchDiscover(page: page)
    }

}

final class MoviesManager: MoviesManaging {

    private let movieService: MovieService
    private let creditsService: CreditsService

    init(movieService: MovieService = TMDbMovieService(), creditsService: CreditsService = TMDbCreditsService()) {
        self.movieService = movieService
        self.creditsService = creditsService
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[MovieListItem], Never> {
        movieService.fetchTrending(timeWindow: .day, page: page)
            .map(\.results)
            .map(MovieListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[MovieListItem], Never> {
        movieService.fetchDiscover(page: page)
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
        movieService.fetch(id: id)
            .map(Movie.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchCredits(forMovie movieID: Movie.ID) -> AnyPublisher<Credits, Never> {
        creditsService.fetch(forMovie: movieID)
            .map(Credits.init)
            .replaceError(with: Credits(id: movieID))
            .eraseToAnyPublisher()
    }

}
