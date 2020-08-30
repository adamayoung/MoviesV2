//
//  MoviesManaging.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol MoviesManaging {

    func fetchTrending(page: Int) -> AnyPublisher<[MovieListItem], Never>

    func fetchDiscover(page: Int) -> AnyPublisher<[MovieListItem], Never>

    func fetchRecommendations(forMovie movieID: Movie.ID) -> AnyPublisher<[MovieListItem], Never>

    func fetchMovie(withID id: Movie.ID) -> AnyPublisher<Movie?, Never>

    func fetchMovieExtended(withID id: Movie.ID) -> AnyPublisher<MovieExtended?, Never>

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
