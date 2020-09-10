//
//  FavouritesService.swift
//  Movies
//
//  Created by Adam Young on 01/09/2020.
//

import Combine
import Foundation

protocol FavouritesService {

    func addFavourite(movie: Movie) -> AnyPublisher<Void, Error>

    func removeFavourite(movie movieID: Movie.ID) -> AnyPublisher<Void, Error>

    func fetchFavourite(movie movieID: Movie.ID) -> AnyPublisher<Movie?, Never>

    func fetchFavouriteMovies() -> AnyPublisher<[Movie], Never>

}
