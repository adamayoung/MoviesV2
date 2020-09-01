//
//  MovieExtended.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Foundation

struct MovieExtended: Identifiable, Equatable {

    let id: Movie.ID
    let movie: Movie
    let credits: Credits?
    let recommendations: [MovieListItem]?

    init(id: Movie.ID, movie: Movie, credits: Credits? = nil, recommendations: [MovieListItem]? = nil) {
        self.id = id
        self.movie = movie
        self.credits = credits
        self.recommendations = recommendations
    }

}
