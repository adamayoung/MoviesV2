//
//  MoviesManager.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol MoviesManager {

    func fetchTrending(page: Int) -> AnyPublisher<[Movie], Never>

    func fetchDiscover(page: Int) -> AnyPublisher<[Movie], Never>

    func fetchRecommendations(forMovie movieID: Movie.ID) -> AnyPublisher<[Movie], Never>

    func fetchMovie(withID id: Movie.ID) -> AnyPublisher<Movie?, Never>

    func fetchCredits(forMovie movieID: Movie.ID) -> AnyPublisher<Credits, Never>

}

extension MoviesManager {

    func fetchTrending(page: Int = 1) -> AnyPublisher<[Movie], Never> {
        fetchTrending(page: page)
    }

    func fetchDiscover(page: Int = 1) -> AnyPublisher<[Movie], Never> {
        fetchDiscover(page: page)
    }

}
